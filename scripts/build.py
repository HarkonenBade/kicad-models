#! /usr/bin/python3

import argparse
import os
import sys
import textwrap

try:
    import sh
except ImportError:
    print("Error: Failed to import sh")
    print("Please install with `pip install sh`")
    sys.exit(1)


def fprint(*args, **kwargs):
    print(*args, **kwargs, flush=True)


try:
    import termcolor

    def succ(text):
        fprint(termcolor.colored(text, "green"))

    def err(text):
        fprint(termcolor.colored(text, "red"))
except ImportError:
    succ = fprint
    err = fprint


def create_readme(scad):
    fprint("  Creating README...", end="")

    header = ""
    body = ""

    with open(scad) as scad_f:
        if scad_f.readline().strip() != "/*":
            err("{} has an invalid layout, defaulting.".format(scad))
            header = "# {}".format(scad)
            body = ""
        else:
            header = "# " + scad_f.readline().strip()
            for line in scad_f:
                if line[:2] == "*/":
                    break
                body += line
            body = textwrap.dedent(body)

    with open("README.md", "w") as readme:
        readme.write(header + "\n")
        readme.write("![Render of {}](./render.png)\n\n".format(scad))
        readme.write("Datasheet: [here](./datasheet.pdf)\n\n")
        readme.write(body)
    succ("Done")


def check_readme(scad):
    if not os.path.exists("README.md"):
        create_readme(scad)
    else:
        readme_time = os.stat("README.md").st_mtime
        source_time = os.stat(scad).st_mtime
        if source_time > readme_time:
            create_readme(scad)
        else:
            fprint("  README upto date")


def create_render(scad):
    fprint("  Rendering...", end="")
    try:
        create_render.openscad("-o", "render.png", scad)
    except:
        err("Fail")
    succ("Done")
create_render.openscad = sh.Command("openscad")
create_render.openscad.bake("--autocenter", "--viewall")


def check_render(scad):
    if os.path.exists("render.png"):
        render_time = os.stat("render.png").st_mtime
        source_time = os.stat(scad).st_mtime
        if source_time > render_time:
            create_render(scad)
        else:
            fprint("  Render upto date")
    else:
        create_render(scad)


def get_args():
    parser = argparse.ArgumentParser()

    force_group = parser.add_mutually_exclusive_group()

    force_group.add_argument("--force-readme", action="store_true")
    force_group.add_argument("--force-render", action="store_true")
    force_group.add_argument("--force-all", action="store_true")

    return parser.parse_args()


def main():
    args = get_args()

    here = os.path.abspath(".")
    parts = os.path.join(here, "parts")

    if "parts" not in os.listdir(here):
        fprint("Please run this from the root of the repo.")
        sys.exit(1)

    fprint("Beginning check.\n")
    for name in os.listdir(parts):
        fprint("Checking {}:".format(name))
        cur = os.path.join(parts, name)
        os.chdir(cur)
        scads = [name for name in os.listdir(cur) if name[-5:] == ".scad"]
        if 0 < len(scads) <= 1:
            if args.force_all or args.force_render:
                create_render(scads[0])
            else:
                check_render(scads[0])

            if args.force_all or args.force_readme:
                create_readme(scads[0])
            else:
                check_readme(scads[0])
        else:
            fprint("{} has {} scad files, it should have 1.".format(name,
                                                                    len(scads)
                                                                    ))
    fprint("\nCheck complete.")

if __name__ == "__main__":
    main()
