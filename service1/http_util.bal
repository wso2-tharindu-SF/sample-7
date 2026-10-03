# Joins a base URL and a path, tolerating a trailing slash on the base — an
# injected address (e.g. SERVICE2_URL) may end in "/", and naive string
# concatenation would then produce a double slash.
function joinUrl(string baseUrl, string path) returns string {
    string trimmedBase = re `/+$`.replace(baseUrl, "");
    if path == "" {
        return trimmedBase;
    }
    string normalizedPath = path.startsWith("/") ? path : "/" + path;
    return trimmedBase + normalizedPath;
}
