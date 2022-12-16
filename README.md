# Github Action Scratchpad

## Runtime

* Start local server: `docker-compose up` -> [http://localhost:3000](http://localhost:3000)


## Bootstrapping Image

Bootstrapping Docker + Node: need to add `package.json`, `index.js` entrypoints

1. Build base `/app/Dockerfile` image, `docker-compose.yml` in parent

2. Generate project files (package.json) and bind mount
   * `docker run -v "$(pwd)"/app:/app -it <image> bash`

3. Update Dockerfile to use project files
   * `npm init`
   * add `start` block to `package.json`
   * `touch index.js`

4. Ensure Dockerfile runs app: `CMD ["npm", "start"]` and rebuild
   (`docker-compose build`)

5. For `npx create-react-app app`, will have to remove contents of bootstrapped `/app`
   directory.

6. Don't lose:
   * Dockerfile: `git checkout Dockerfile`, etc.
   * add ports or mapping for app execution in `docker-compose.yml` (e.g.
     react-app served on 3000)
