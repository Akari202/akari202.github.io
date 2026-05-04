exports.handler = async (event) => {
  const { Octokit } = await import("@octokit/rest");
  const headers = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "Content-Type",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
  };

  if (event.httpMethod === "OPTIONS") {
    return { statusCode: 200, headers, body: "OK" };
  }

  if (event.httpMethod !== "POST") {
    return { statusCode: 405, headers, body: "Method Not Allowed" };
  }

  const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN });
  const { gistId, content, filename } = JSON.parse(event.body);

  try {
    await octokit.gists.update({
      gist_id: gistId,
      files: { [filename]: { content } }
    });
    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({ message: "Gist updated" })
    };
  } catch (error) {
    return {
      statusCode: 500,
      headers,
      body: JSON.stringify({ error: error.toString() })
    };
  }
};
