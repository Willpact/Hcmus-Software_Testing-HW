#!/usr/bin/env node

const path = require('path');

function resolveFromRoot(root, candidate) {
  return candidate ? path.resolve(root, candidate) : null;
}

function runtimeLayout(root) {
  const artifactRoot = resolveFromRoot(root, process.env.HW06_CI_ARTIFACT_ROOT)
    || path.join(root, 'test-results', 'hw06');
  const runtimeEnvironment = resolveFromRoot(root, process.env.HW06_RUNTIME_ENV_PATH)
    || path.join(root, 'test-results', 'hw06', 'runtime', 'HW06-Local.runtime.postman_environment.json');
  const sutRoot = resolveFromRoot(root, process.env.HW06_SUT_ROOT)
    || path.resolve(root, '..', 'eshop-sut');

  return {
    artifactRoot,
    runtimeEnvironment,
    sutRoot,
    runOut: path.join(artifactRoot, 'run-002'),
    smokeOut: path.join(artifactRoot, 'smoke-rerun-001'),
    mode: process.env.HW06_CI_RUN_MODE || 'normal',
  };
}

module.exports = { runtimeLayout };
