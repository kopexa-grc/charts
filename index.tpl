<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Kopexa Helm Charts</title>
    <link rel="icon" href="/assets/favicon.ico" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/2.10.0/github-markdown.min.css" />
    <style>
      :root {
        --bg: #0b0f1a;
        --panel: #121829;
        --fg: #e7ecf3;
        --muted: #99a3b3;
        --brand: #5b8cff;
        --brand-2: #7aa2ff;
        --border: #1e263d;
      }
      html, body { height: 100%; }
      body {
        margin: 0;
        background: radial-gradient(1200px 600px at 70% -10%, rgba(91,140,255,0.15), transparent),
                    radial-gradient(900px 500px at -10% 20%, rgba(122,162,255,0.12), transparent),
                    var(--bg);
        color: var(--fg);
        font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, "Apple Color Emoji", "Segoe UI Emoji";
      }
      .container {
        max-width: 1000px;
        margin: 0 auto;
        padding: 32px 20px 60px;
      }
      header.hero {
        display: grid;
        gap: 10px;
        margin: 20px 0 28px;
      }
      header.hero h1 {
        margin: 0;
        font-size: 28px;
        letter-spacing: 0.3px;
      }
      header.hero p {
        margin: 0;
        color: var(--muted);
      }
      .panel { background: var(--panel); border: 1px solid var(--border); border-radius: 12px; }
      .usage { padding: 16px 18px; margin-bottom: 18px; }
      .usage h2 { font-size: 16px; margin: 0 0 10px; color: var(--brand-2); }
      pre { margin: 0; background: #0e1424; border: 1px solid var(--border); padding: 12px; border-radius: 10px; overflow: auto; }
      code { color: #cfe1ff; }
      .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 14px; }
      .card { padding: 16px; }
      .card h3 { margin: 0 0 6px; font-size: 16px; }
      .meta { color: var(--muted); font-size: 12px; margin-bottom: 8px; }
      .desc { color: var(--fg); opacity: 0.9; font-size: 14px; margin: 8px 0 12px; }
      .links a { color: var(--brand); text-decoration: none; margin-right: 12px; }
      .links a:hover { text-decoration: underline; }
      footer { margin-top: 26px; color: var(--muted); font-size: 12px; text-align: center; }
    </style>
  </head>
  <body>
    <div class="container">
      <header class="hero">
        <h1>Kopexa Helm Charts</h1>
        <p>Official Helm charts for Kopexa components and integrations.</p>
      </header>

      <section class="panel usage">
        <h2>Use via classic Helm repository</h2>
        <pre><code># Add Kopexa charts repo (GitHub Pages)
helm repo add kopexa https://kopexa-grc.github.io/charts
helm repo update
# Search and install
helm search repo kopexa
helm install my-kopexa kopexa/kopexa --version {{ (index (index .Entries "kopexa") 0).Version }} -f values.yaml</code></pre>
      </section>

      <section class="panel usage">
        <h2>Use via OCI (GHCR)</h2>
        <pre><code># Login to GHCR and install a chart directly from OCI
helm registry login ghcr.io
# Example for the 'kopexa' chart
helm install my-kopexa oci://ghcr.io/kopexa-grc/charts/kopexa --version {{ (index (index .Entries "kopexa") 0).Version }} -f values.yaml
# Or pull the package locally
helm pull oci://ghcr.io/kopexa-grc/charts/kopexa --version {{ (index (index .Entries "kopexa") 0).Version }}</code></pre>
      </section>

      <section class="grid">
        {{- range $name, $versions := .Entries }}
        {{- $latest := (index $versions 0) }}
        <article class="panel card">
          <h3>{{$latest.Name}}</h3>
          <div class="meta">version {{$latest.Version}} · app {{$latest.AppVersion}}</div>
          <div class="desc">{{ $latest.Description }}</div>
          <div class="links">
            {{- if $latest.Home }}<a href="{{$latest.Home}}" target="_blank" rel="noopener">Home</a>{{- end }}
            {{- if (index $latest.Urls 0) }}<a href="{{ (index $latest.Urls 0) }}" target="_blank" rel="noopener">Chart (tgz)</a>{{- end }}
          </div>
          {{- if $latest.Maintainers }}
          <div class="meta" style="margin-top:8px;">Maintainers:
            {{- range $i, $m := $latest.Maintainers }}
              {{- if $i }}, {{ end -}}
              {{- if $m.Url }}<a href="{{$m.Url}}" target="_blank" rel="noopener">{{$m.Name}}</a>{{- else }}{{$m.Name}}{{- end -}}
            {{- end }}
          </div>
          {{- end }}
          <div class="meta" style="margin-top:8px;">Install:
            <code>helm install my-{{ $latest.Name }} kopexa/{{ $latest.Name }} --version {{ $latest.Version }}</code>
          </div>
        </article>
        {{- end }}
      </section>

      <footer>
        <time datetime="{{ .Generated.Format "2006-01-02T15:04:05" }}" pubdate id="generated">Updated {{ .Generated.Format "Mon Jan 2 2006 03:04:05PM MST-07:00" }}</time>
        · © Kopexa
      </footer>
    </div>
  </body>
</html>