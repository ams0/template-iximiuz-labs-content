# iximiuz Labs Content

Interactive learning content for cloud-native and infrastructure engineering.

## Content Types

- **Challenges** (`/challenges/`) - Short, focused exercises with verification tasks
- **Playgrounds** (`/playgrounds/`) - Pre-configured interactive environments
- **Tutorials** (`/tutorials/`) - Step-by-step guides with hands-on tasks
- **Trainings** (`/trainings/`) - Workshop content (naming: `YYYY-MM-DD-{event}-{topic}`)
- **Courses** (`/courses/`) - Multi-module programs with numbered chapters/lessons

Each content item has:
- `manifest.yaml` - Metadata, tasks, playground config
- `index.md` - Main content (custom markdown with `::simple-task`, `::hint-box`, etc.)
- `solution.md` - Solutions (for challenges)

## Syntax

The basic syntax is available [here](https://raw.githubusercontent.com/iximiuz/labs-content-samples/refs/heads/main/sample-tutorial/index.md).

## Writing Style

### Voice
- Expert educator who enjoys teaching - technically rigorous but never condescending
- First-person plural ("we", "you", "our") to create connection
- Conversational asides that show personality without losing professionalism
- Trust the reader's intelligence while providing scaffolding

### Structure
- Lead with "why" before "how"
- Progressive complexity - simple concepts first, then build
- Heavy use of tables for comparisons and component lists
- Bullet points and numbered lists for scannability
- Short, punchy opening sentences

### Tone Markers (use these patterns)
- "Try this at home (not at work!)" - playful safety framing
- "No need to..." - acknowledging pain points being solved
- "Here's a fun fact:" - introducing interesting tangents
- "Happy learning!" - signature closing (but only at end of content)
- Strategic emoji use: limited to closings and celebrations

### Technical Writing
- Define terms contextually: "etcd - Distributed key-value store that holds all cluster data"
- Provide actual commands, not abstract descriptions
- Show expected output after commands
- Use `::details-box` or `::hint-box` for optional/advanced info
- Active voice: "You'll configure..." not "The configuration will be..."

## Anti-Patterns (AVOID THESE)

### AI Slop Markers - DO NOT USE
- "Let's dive in" / "dive into" / "deep dive"
- "In this comprehensive guide"
- "It's important to note that..."
- "As we can see..."
- "This powerful feature..."
- "Let's explore..." (at paragraph starts)
- "In conclusion" / "To summarize"
- Excessive hedging: "might", "could potentially", "it's worth considering"
- Empty transitions: "Now that we've covered X, let's move on to Y"
- Filler praise: "This elegant solution" / "beautifully designed"

### Structural Anti-Patterns
- Don't over-explain simple concepts
- Don't add disclaimers about what's "outside the scope"
- Don't pad with unnecessary context before getting to the point
- Don't use generic introductions - get specific immediately
- Don't explain why the reader should care in abstract terms - show them

### Example Transformations

Bad (AI slop):
"In this comprehensive tutorial, we'll dive deep into HAProxy, a powerful load balancing solution. It's important to note that load balancing is a crucial concept in modern infrastructure."

Good (actual style):
"HAProxy is a free, open source, high-performance and reliable reverse proxy offering high availability, load balancing, and proxying for TCP and HTTP-based applications."

Bad:
"Let's explore what makes this different from other approaches."

Good:
"What makes this different?"

Bad:
"Now that we understand the basics, let's move on to the configuration section where we'll configure the various components."

Good:
"Now that you're familiar with HAProxy's core concepts, let's walk through some example configurations."

## Content Patterns

### Challenge Structure
- Hook with an interesting problem or surprising fact
- State the scenario concisely
- Define the task clearly
- Use `::simple-task` for verification

Example opener:
"Pods are one of the most important and well-known concepts in Kubernetes.
But did you know that pods can become 'invisible'?"

### Playground READMEs
- Welcome with bold product name
- Acknowledge what's already set up (the value proposition)
- "Try this at home" framing for learning safety
- Architecture overview with tables
- "Getting Started" numbered list
- Component version table

### Tutorial Structure
- One-liner product description with link
- "In this tutorial, you will learn how to:" bullet list
- `::details-box` for "Why bother?" motivation (optional reading)
- Concepts section before hands-on
- Step-by-step with verification tasks
- Summary with "Congratulations!"

## File Conventions

- Main content: `index.md`
- Slugs: `kebab-case`
- Modules: `01-`, `02-` numeric prefixes
- Images: `__static__/` prefix in markdown, actual files in `static/`
- Template variables: `{{ .Extra.bake.VERSION }}`

## Build & Test

```bash
just lint        # Lint content
just build       # Build content
just test        # Run tests
```

Uses `labctl` and `labx` tools (available via nix flake).
