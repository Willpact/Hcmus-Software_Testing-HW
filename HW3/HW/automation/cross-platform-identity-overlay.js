(() => {
  const studentName = "REPLACE_WITH_FULL_NAME";
  const studentEmail = "REPLACE_WITH_STUDENT_ID@hcmus.edu.vn";

  if (
    studentName.startsWith("REPLACE_") ||
    studentEmail.startsWith("REPLACE_")
  ) {
    throw new Error("Replace the student identity placeholders first.");
  }

  document.getElementById("hw03-student-overlay")?.remove();
  const overlay = document.createElement("div");
  overlay.id = "hw03-student-overlay";
  overlay.textContent = `${studentName} | ${studentEmail}`;
  Object.assign(overlay.style, {
    position: "fixed",
    zIndex: "2147483647",
    top: "8px",
    left: "50%",
    transform: "translateX(-50%)",
    padding: "8px 12px",
    background: "#111827",
    color: "#ffffff",
    border: "2px solid #facc15",
    borderRadius: "6px",
    font: "700 16px/1.2 Arial, sans-serif",
    maxWidth: "95vw",
    whiteSpace: "nowrap",
    boxShadow: "0 2px 8px rgba(0,0,0,.35)",
  });
  document.body.appendChild(overlay);
})();
