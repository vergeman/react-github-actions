# Github Action Scratchpad

## Runtime

* Live: [https://vergeman.github.io/react-github-actions/](https://vergeman.github.io/react-github-actions/)
* Start local server: `docker-compose up` -> [http://localhost:3000](http://localhost:3000)
* Deploy Branch:
  [https://github.com/vergeman/react-github-actions/tree/gh-pages](https://github.com/vergeman/react-github-actions/tree/gh-pages)
  deployed by actions

## Github Actions

* [Actions Dashboard](https://github.com/vergeman/react-github-actions/actions)
* Workflows: [`.github/workflows`](https://github.com/vergeman/react-github-actions/tree/master/.github/workflows)
* Most are manually disabled via dash, but typically triggered by defined branch
  push
* Best to approach workflows and jobs as stateless; upload/download artificates
  to share state between jobs
* Distinction between dev env:
    * Easier to pull a vanilla docker hub container and clone into it, versus
  building bespoke project container from `Dockerfile`. So there could be env
  drift.
    * The latter seems to require publishing/dl image to a container repository
      (ECR, Docker Hub), or upload/download container as an artificat (.tar) for
      reuse across jobs.
    * [Discussion](https://github.com/docker/build-push-action/issues/225)

## Github Action Environment Secrets

* Typically have `docker-compose.override.yml` to read `.env.local` secrets for
  react app.
* For build, currently set environment variables and secrets in `<workspace>.yml`
  (no docker-compose.yml)
* For environment-defined secrets on Github, need to specifiy job's `environment`
  in `<workspace>.yml` or values or empty.
* Also look at marketplace for actions that allow larger scale env var
  injection.

Currently have environment `staging` applying to all branches, and manually input demo
secrets via Github web.

NB: note `GH_ENV_SECRET` corresponds to `staging` environment - which is when
static site gets build. The value in `gh-pages` deploy environment never makes
it to the app. (already built.)

## Notes Bootstrapping Docker + Node

Want npm generated files, editable source to appear in mounted `app` directory .
e.g. `npm init` generates `package.json`, `index.js`. Don't want "locked" in
container.

1. Build base `/app/Dockerfile` image, `docker-compose.yml` in parent if needed.
   * `docker-compose build`

2. Run base image shell with bind mount (or run commands directly):
   * `docker run -v "$(pwd)"/app:/app -it <image> bash`

3. In container's shell; run commands below, generated output written to mounted
   dir:
   * `npm init` / `npx create-react-app`
   * `package.json`: add`start` block to `node index.js`, or project equivalent.

4. Ensure Dockerfile runs app: `CMD ["npm", "start"]` and rebuild
   (`docker-compose build`)

5. NB: for `npx create-react-app app`, need to remove contents of
   bootstrapped `/app` directory.
   * Dockerfile: `git checkout Dockerfile`, add back Dockerfile, etc.
   * add any port mapping for app as a server in `docker-compose.yml` (e.g.
     react-app dev server on 3000:3000)
