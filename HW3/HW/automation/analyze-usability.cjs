const fs = require("node:fs");
const path = require("node:path");

const dataDir = path.resolve(
  process.env.HW03_USABILITY_DATA_DIR ||
    path.join(__dirname, "..", "submission", "task2-usability", "data"),
);
const outputDir = path.resolve(
  process.env.HW03_USABILITY_OUTPUT_DIR ||
    path.join(__dirname, "..", "submission", "task2-usability", "analysis"),
);

function parseCsv(filename) {
  const text = fs.readFileSync(path.join(dataDir, filename), "utf8").trim();
  const lines = text.split(/\r?\n/);
  const headers = lines.shift().split(",");
  return lines
    .filter((line) => line.trim())
    .map((line) => {
      const values = line.split(",");
      return Object.fromEntries(headers.map((header, index) => [header, values[index] ?? ""]));
    });
}

function numberInRange(value, min, max) {
  if (value === "") return null;
  const number = Number(value);
  if (!Number.isFinite(number) || number < min || number > max) return NaN;
  return number;
}

function median(values) {
  const sorted = [...values].sort((a, b) => a - b);
  const middle = Math.floor(sorted.length / 2);
  return sorted.length % 2
    ? sorted[middle]
    : (sorted[middle - 1] + sorted[middle]) / 2;
}

const susRows = parseCsv("sus-responses.csv");
const metricRows = parseCsv("session-metrics.csv");
const expectedIds = Array.from({ length: 7 }, (_, index) => `P0${index + 1}`);
const errors = [];

for (const id of expectedIds) {
  const sus = susRows.find((row) => row.participant_id === id);
  const metric = metricRows.find((row) => row.participant_id === id);
  if (!sus) errors.push(`${id}: missing SUS row`);
  if (!metric) errors.push(`${id}: missing metrics row`);
  if (!sus || !metric) continue;

  for (let item = 1; item <= 10; item += 1) {
    const value = numberInRange(sus[`q${item}`], 1, 5);
    if (value === null) errors.push(`${id}: q${item} is blank`);
    else if (Number.isNaN(value)) errors.push(`${id}: q${item} must be 1-5`);
  }

  for (const [field, min, max] of [
    ["success", 0, 1],
    ["time_seconds", 1, 3600],
    ["errors", 0, 100],
    ["assists", 0, 100],
    ["critical_incidents", 0, 100],
  ]) {
    const value = numberInRange(metric[field], min, max);
    if (value === null) errors.push(`${id}: ${field} is blank`);
    else if (Number.isNaN(value)) errors.push(`${id}: ${field} is outside ${min}-${max}`);
  }
}

if (errors.length > 0) {
  console.error("Usability analysis blocked: real session data is incomplete.");
  for (const error of errors) console.error(`- ${error}`);
  process.exit(2);
}

const individual = expectedIds.map((id) => {
  const sus = susRows.find((row) => row.participant_id === id);
  const metric = metricRows.find((row) => row.participant_id === id);
  const responses = Array.from({ length: 10 }, (_, index) => Number(sus[`q${index + 1}`]));
  const contribution = responses.reduce((sum, response, index) => {
    const itemNumber = index + 1;
    return sum + (itemNumber % 2 === 1 ? response - 1 : 5 - response);
  }, 0);
  return {
    participantId: id,
    susScore: contribution * 2.5,
    success: Number(metric.success),
    timeSeconds: Number(metric.time_seconds),
    errors: Number(metric.errors),
    assists: Number(metric.assists),
    criticalIncidents: Number(metric.critical_incidents),
    recordingFile: metric.recording_file,
  };
});

const sum = (field) => individual.reduce((total, row) => total + row[field], 0);
const summary = {
  participantCount: individual.length,
  successfulParticipants: sum("success"),
  taskSuccessRate: sum("success") / individual.length,
  meanSus: sum("susScore") / individual.length,
  medianTimeSeconds: median(individual.map((row) => row.timeSeconds)),
  participantsNeedingAssistance: individual.filter((row) => row.assists > 0).length,
  totalErrors: sum("errors"),
  totalAssists: sum("assists"),
  totalCriticalIncidents: sum("criticalIncidents"),
};

fs.mkdirSync(outputDir, { recursive: true });
fs.writeFileSync(
  path.join(outputDir, "usability-analysis.json"),
  JSON.stringify({ generatedAt: new Date().toISOString(), summary, individual }, null, 2),
);

const markdown = [
  "# Computed Usability Results",
  "",
  `- Participants: ${summary.participantCount}`,
  `- Successful participants: ${summary.successfulParticipants}/${summary.participantCount}`,
  `- Task success rate: ${(summary.taskSuccessRate * 100).toFixed(1)}%`,
  `- Mean SUS: ${summary.meanSus.toFixed(1)}`,
  `- Median time: ${summary.medianTimeSeconds.toFixed(0)} seconds`,
  `- Participants needing assistance: ${summary.participantsNeedingAssistance}`,
  `- Total observed errors: ${summary.totalErrors}`,
  `- Total critical incidents: ${summary.totalCriticalIncidents}`,
  "",
  "| Participant | SUS | Success | Time (s) | Errors | Assists | Critical incidents | Recording |",
  "|---|---:|---:|---:|---:|---:|---:|---|",
  ...individual.map(
    (row) =>
      `| ${row.participantId} | ${row.susScore.toFixed(1)} | ${row.success} | ${row.timeSeconds} | ${row.errors} | ${row.assists} | ${row.criticalIncidents} | ${row.recordingFile} |`,
  ),
  "",
  "> These are computed values only. Interpret themes and severity from real",
  "> observation notes; do not infer qualitative findings from SUS alone.",
  "",
].join("\n");

fs.writeFileSync(path.join(outputDir, "usability-analysis.md"), markdown);
console.log(JSON.stringify(summary, null, 2));
