# Github Action Scratchpad

Bootstrapping Docker + Node: need to add `package.json`, `index.js` entrypoints

1. Build base `/app/Dockerfile` image, `docker-compose.yml` in parent

2. Generate project files (package.json) and bind mount
   * `docker run -v "$(pwd)"/app:/app -it <image> bash`

3. Update Dockerfile to use project files
   * `npm init`
   * add `start` block to `package.json`
   * `touch index.js` or `npx create-react-app`, etc.

4. Ensure Dockerfile runs app: `CMD ["npm", "start"]` and rebuild
   (`docker-compose build`)

5. Profit?
