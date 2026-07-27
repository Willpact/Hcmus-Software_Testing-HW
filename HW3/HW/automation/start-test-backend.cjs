const fs = require("node:fs");
const path = require("node:path");
const Module = require("node:module");

const backendDir = path.resolve(__dirname, "..", "eshop-sut", "backend");
const filename = path.join(backendDir, "server.js");
const requestedPort = Number(process.env.HW03_BACKEND_PORT || 3001);

let source = fs.readFileSync(filename, "utf8");
source = source.replace(
  "const PORT = 3000;",
  `const PORT = ${JSON.stringify(requestedPort)};`,
);

if (!source.includes(`const PORT = ${JSON.stringify(requestedPort)};`)) {
  throw new Error("Could not override the test backend port");
}

const testModule = new Module(filename, module);
testModule.filename = filename;
testModule.paths = Module._nodeModulePaths(backendDir);
testModule._compile(source, filename);
