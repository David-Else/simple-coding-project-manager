# simple-coding-project-manager

Utility to allow the selection of a project to edit using the command line by browsing a fixed format folder structure.

Designed for simplicity, it can be used with any programming language, but currently only has additional features for JavsScript/TypeScript. It assumes use of [pnpm](https://github.com/pnpm/pnpm) as your package manager.

         Dir structure in PROJECT_FOLDER must have two levels for selection:

           ├── language-name
           │   ├── project-name

Intelligent inspection of the `project-name` folder chosen gives the user options.

For JavaScript and TypeScript projects:

- Check/update the dependencies using pnpm if `package.json` found
- Run Rollup watch if Rollup local install detected
- Edit in Visual Studio Code

## Usage

Place the script in the system `$PATH` and check it is executable. Run it.
