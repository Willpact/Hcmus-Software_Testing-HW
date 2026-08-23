const path = require('path');

const sourceSetting = process.env.HW06_SUT_DATABASE_PATH;
const runtimeSetting = process.env.HW06_RUNTIME_DATABASE_PATH;
if (!sourceSetting || !runtimeSetting) {
  throw new Error('HW06 SQLite redirect requires HW06_SUT_DATABASE_PATH and HW06_RUNTIME_DATABASE_PATH');
}

const sourceDatabase = path.resolve(sourceSetting);
const runtimeDatabase = path.resolve(runtimeSetting);
const originalResolve = path.resolve;
const normalized = (value) => process.platform === 'win32' ? value.toLowerCase() : value;

path.resolve = function resolveWithRuntimeDatabase(...parts) {
  const resolved = originalResolve(...parts);
  return normalized(resolved) === normalized(sourceDatabase) ? runtimeDatabase : resolved;
};

console.log('HW06 runtime harness: SQLite path redirected to a fresh isolated test database.');
