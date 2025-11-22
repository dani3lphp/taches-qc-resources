---
name: create-agent-skills
description: Expert guidance for creating, writing, building, and refining Claude Code Skills. Use when working with SKILL.md files, authoring new skills, improving existing skills, or understanding skill structure and best practices.
---

<essential_principles>
## How Skills Work

Skills are modular, filesystem-based capabilities that provide domain expertise on demand. This skill teaches how to create effective skills.

### 1. Skills Are Prompts

All prompting best practices apply. Be clear, be direct, use XML structure. Assume Claude is smart - only add context Claude doesn't have.

### 2. SKILL.md Is Always Loaded

When a skill is invoked, Claude reads SKILL.md. Use this guarantee:
- Essential principles go in SKILL.md (can't be skipped)
- Workflow-specific content goes in workflows/
- Reusable knowledge goes in references/

### 3. Router Pattern for Complex Skills

```
skill-name/
├── SKILL.md              # Router + principles
├── workflows/            # Step-by-step procedures (FOLLOW)
├── references/           # Domain knowledge (READ)
├── templates/            # Output structures (COPY + FILL)
└── scripts/              # Reusable code (EXECUTE)
```

SKILL.md asks "what do you want to do?" → routes to workflow → workflow specifies which references to read.

**When to use each folder:**
- **workflows/** - Multi-step procedures Claude follows
- **references/** - Domain knowledge Claude reads for context
- **templates/** - Consistent output structures Claude copies and fills (plans, specs, configs)
- **scripts/** - Executable code Claude runs as-is (deploy, setup, API calls)

### 4. Pure XML Structure

No markdown headings (#, ##, ###) in skill body. Use semantic XML tags:
```xml
<objective>...</objective>
<process>...</process>
<success_criteria>...</success_criteria>
```

Keep markdown formatting within content (bold, lists, code blocks).

### 5. Progressive Disclosure

SKILL.md under 500 lines. Split detailed content into reference files. Load only what's needed for the current workflow.
</essential_principles>

<context_scan>
**Run on every invocation to understand current state:**

```bash
# Are we in a skill directory?
if [ -f "SKILL.md" ]; then
    SKILL_NAME=$(grep "^name:" SKILL.md 2>/dev/null | cut -d: -f2 | xargs)
    echo "IN_SKILL: $SKILL_NAME"

    # What structure exists?
    [ -d "workflows" ] && echo "HAS: workflows/"
    [ -d "references" ] && echo "HAS: references/"
    [ -d "templates" ] && echo "HAS: templates/"
    [ -d "scripts" ] && echo "HAS: scripts/"

    # Router or simple?
    grep -q "<intake>" SKILL.md && echo "PATTERN: router" || echo "PATTERN: simple"
else
    echo "NOT_IN_SKILL"
fi

# Show available expertise skills
echo "EXPERTISE_SKILLS:"
ls ~/.claude/skills/expertise/ 2>/dev/null | head -5
```

**Present findings before intake question.**
</context_scan>

<intake>
**If IN skill directory:**
```
Working in: {skill-name} ({pattern})
Components: {what exists}

What would you like to do?
1. Add component (workflow/reference/template/script)
2. Audit this skill
3. Verify content is current
4. Upgrade to router pattern
5. Create different skill
6. Get guidance
```

**If NOT in skill directory:**
```
What would you like to do?
1. Create new skill
2. Audit/modify existing skill
3. Get guidance
```

**Wait for response before proceeding.**
</intake>

<routing>
**When IN skill directory:**

| Response | Next Action | Workflow |
|----------|-------------|----------|
| 1, "add", "component" | Ask: "Add what? (workflow/reference/template/script)" | workflows/add-{type}.md |
| 2, "audit", "check", "review" | Audit current directory | workflows/audit-skill.md |
| 3, "verify", "fresh", "current" | Verify current directory | workflows/verify-skill.md |
| 4, "upgrade", "router", "restructure" | Upgrade current directory | workflows/upgrade-to-router.md |
| 5, "create", "new", "different" | Exit directory, route to create flow | workflows/create-new-skill.md OR create-domain-expertise-skill.md |
| 6, "guidance", "help" | General guidance | workflows/get-guidance.md |

**When NOT in skill directory:**

| Response | Next Action | Workflow |
|----------|-------------|----------|
| 1, "create", "new", "build" | Ask: "Task-execution skill or domain expertise skill?" | Route to appropriate create workflow |
| 2, "audit", "modify", "existing" | Ask: "Path to skill?" | Route to appropriate workflow |
| 3, "guidance", "help" | General guidance | workflows/get-guidance.md |

**Progressive disclosure for option 1 (create):**
- If user selects "Task-execution skill" → workflows/create-new-skill.md
- If user selects "Domain expertise skill" → workflows/create-domain-expertise-skill.md

**Progressive disclosure for add component:**
- If user specifies workflow → workflows/add-workflow.md
- If user specifies reference → workflows/add-reference.md
- If user specifies template → workflows/add-template.md
- If user specifies script → workflows/add-script.md

**After reading the workflow, follow it exactly.**
</routing>

<quick_reference>
## Skill Structure Quick Reference

**Simple skill (single file):**
```yaml
---
name: skill-name
description: What it does and when to use it.
---

<objective>What this skill does</objective>
<quick_start>Immediate actionable guidance</quick_start>
<process>Step-by-step procedure</process>
<success_criteria>How to know it worked</success_criteria>
```

**Complex skill (router pattern):**
```
SKILL.md:
  <essential_principles> - Always applies
  <intake> - Question to ask
  <routing> - Maps answers to workflows

workflows/:
  <required_reading> - Which refs to load
  <process> - Steps
  <success_criteria> - Done when...

references/:
  Domain knowledge, patterns, examples

templates/:
  Output structures Claude copies and fills
  (plans, specs, configs, documents)

scripts/:
  Executable code Claude runs as-is
  (deploy, setup, API calls, data processing)
```
</quick_reference>

<reference_index>
## Domain Knowledge

All in `references/`:

**Structure:** recommended-structure.md, skill-structure.md
**Principles:** core-principles.md, be-clear-and-direct.md, use-xml-tags.md
**Patterns:** common-patterns.md, workflows-and-validation.md
**Assets:** using-templates.md, using-scripts.md
**Advanced:** executable-code.md, api-security.md, iteration-and-testing.md
</reference_index>

<workflows_index>
## Workflows

All in `workflows/`:

| Workflow | Purpose |
|----------|---------|
| create-new-skill.md | Build a skill from scratch |
| create-domain-expertise-skill.md | Build exhaustive domain knowledge base for build/ |
| audit-skill.md | Analyze skill against best practices |
| verify-skill.md | Check if content is still accurate |
| add-workflow.md | Add a workflow to existing skill |
| add-reference.md | Add a reference to existing skill |
| add-template.md | Add a template to existing skill |
| add-script.md | Add a script to existing skill |
| upgrade-to-router.md | Convert simple skill to router pattern |
| get-guidance.md | Help decide what kind of skill to build |
</workflows_index>

<yaml_requirements>
## YAML Frontmatter

Required fields:
```yaml
---
name: skill-name          # lowercase-with-hyphens, matches directory
description: ...          # What it does AND when to use it (third person)
---
```

Name conventions: `create-*`, `manage-*`, `setup-*`, `generate-*`, `build-*`
</yaml_requirements>

<success_criteria>
A well-structured skill:
- Context scan runs on every invocation
- Presents context-aware options (different if in skill directory)
- Has valid YAML frontmatter
- Uses pure XML structure (no markdown headings in body)
- Has essential principles inline in SKILL.md
- Routes to focused workflows
- Keeps SKILL.md under 500 lines
- Uses progressive disclosure (max 6 options, then follow-up questions)
- Has been tested with real usage
</success_criteria>
