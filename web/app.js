const problemEl = document.getElementById('problem');
const outputEl = document.getElementById('output');
document.getElementById('solve').addEventListener('click', async () => {
  const problem = encodeURIComponent(problemEl.value.trim());
  if (!problem) return;
  const response = await fetch(`/api/advice?problem=${problem}`);
  const data = await response.json();
  outputEl.textContent = JSON.stringify(data, null, 2);
});
