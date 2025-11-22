# Workflow: Create Exhaustive Domain Expertise Skill

<objective>
Build a comprehensive knowledge base that other skills (like create-plans) can load to make domain-appropriate decisions. This is NOT a skill that executes tasks—it's a complete domain reference that gets consumed by other skills.
</objective>

<critical_distinction>
**Regular skill:** "Know enough to do a specific task"
**Domain expertise skill:** "Know EVERYTHING a professional practitioner knows"

Examples:
- `build/python-games` - Complete Python game development knowledge
- `build/rust-systems` - Exhaustive Rust systems programming expertise
- `build/machine-learning` - Comprehensive ML/AI domain knowledge

When create-plans loads `build/python-games/` to plan a game project, it needs ALL libraries, ALL patterns, ALL lifecycle stages, ALL platform considerations, ALL distribution strategies.

If incomplete, roadmaps miss critical phases, wrong architectures get chosen, phases planned in wrong order.
</critical_distinction>

<required_reading>
**Read these reference files NOW:**
1. references/recommended-structure.md
2. references/core-principles.md
3. references/use-xml-tags.md
</required_reading>

<process>
## Step 1: Identify Domain

Ask user what domain expertise to build:

**Example domains:**
- Python game development
- Rust systems programming
- Machine learning / AI
- Mobile game development (Unity/Unreal)
- Web scraping and automation
- Data engineering pipelines
- Embedded systems
- Computer graphics / shaders
- Audio processing / DSP
- Blockchain / smart contracts

Get specific: "Python games" or "Python games with Pygame specifically"?

## Step 2: Confirm Target Location

Explain:
```
Domain expertise skills go in: ~/.claude/skills/expertise/{domain-name}/

These are loaded BY other skills (like create-plans) to provide
domain-specific knowledge during planning and execution.

Name suggestion: {suggested-name}
Location: ~/.claude/skills/expertise/{suggested-name}/
```

Confirm or adjust name.

## Step 3: Exhaustive Research Phase

**CRITICAL:** This research must be comprehensive, not superficial.

### Research Strategy

Run multiple web searches to ensure coverage:

**Search 1: Current ecosystem**
- "best {domain} libraries 2024 2025"
- "popular {domain} frameworks comparison"
- "{domain} tech stack recommendations"

**Search 2: Architecture patterns**
- "{domain} architecture patterns"
- "{domain} best practices design patterns"
- "how to structure {domain} projects"

**Search 3: Lifecycle and tooling**
- "{domain} development workflow"
- "{domain} testing debugging best practices"
- "{domain} deployment distribution"

**Search 4: Common pitfalls**
- "{domain} common mistakes avoid"
- "{domain} anti-patterns"
- "what not to do {domain}"

**Search 5: Real-world usage**
- "{domain} production examples GitHub"
- "{domain} case studies"
- "successful {domain} projects"

### Verification Requirements

For EACH major library/tool/pattern found:
- **Check recency:** When was it last updated?
- **Check adoption:** Is it actively maintained? Community size?
- **Check alternatives:** What else exists? When to use each?
- **Check deprecation:** Is anything being replaced?

**Red flags for outdated content:**
- Articles from before 2023 (unless fundamental concepts)
- Abandoned libraries (no commits in 12+ months)
- Deprecated APIs or patterns
- "This used to be popular but..."

### Documentation Sources

Use Context7 MCP when available:
```
mcp__context7__resolve-library-id: {library-name}
mcp__context7__get-library-docs: {library-id}
```

Focus on official docs, not tutorials.

## Step 4: Organize Knowledge Into Domain Areas

Structure references by domain concerns, NOT by arbitrary categories.

**For game development example:**
```
references/
├── architecture.md         # ECS, component-based, state machines
├── libraries.md           # Pygame, Arcade, Panda3D (when to use each)
├── graphics-rendering.md  # 2D/3D rendering, sprites, shaders
├── physics.md             # Collision, physics engines
├── audio.md               # Sound effects, music, spatial audio
├── input.md               # Keyboard, mouse, gamepad, touch
├── ui-menus.md            # HUD, menus, dialogs
├── game-loop.md           # Update/render loop, fixed timestep
├── state-management.md    # Game states, scene management
├── networking.md          # Multiplayer, client-server, P2P
├── asset-pipeline.md      # Loading, caching, optimization
├── testing-debugging.md   # Unit tests, profiling, debugging tools
├── performance.md         # Optimization, profiling, benchmarking
├── packaging.md           # Building executables, installers
├── distribution.md        # Steam, itch.io, app stores
└── anti-patterns.md       # Common mistakes, what NOT to do
```

**For each reference file:**
- Pure XML structure
- Decision trees: "If X, use Y. If Z, use A instead."
- Comparison tables: Library vs Library (speed, features, learning curve)
- Code examples showing patterns
- "When to use" guidance
- Platform-specific considerations
- Current versions and compatibility

## Step 5: Create SKILL.md

Domain expertise skills use router pattern:

```yaml
---
name: {domain-name}
description: Exhaustive {domain} expertise. Comprehensive knowledge of libraries, patterns, architecture, lifecycle, and best practices. Loaded by other skills (create-plans, etc.) to make domain-appropriate decisions.
---

<domain_coverage>
## What This Expertise Covers

**Complete coverage of:**
- All major libraries and frameworks (with when to use each)
- All architectural patterns and when to apply them
- Full development lifecycle (setup → dev → test → optimize → ship)
- Platform-specific considerations
- Common pitfalls and anti-patterns
- Current best practices (2024-2025)
</domain_coverage>

<how_to_use>
## How Other Skills Use This

This is a **knowledge base**, not an execution skill.

**Consumed by:**
- create-plans: Load references when planning {domain} projects
- Other build skills: Access domain patterns during implementation

**Not for:**
- Direct user invocation (no intake/routing)
- Task execution (knowledge only)
</how_to_use>

<reference_index>
## Domain Knowledge

All in `references/`:

**{Category 1}:** file1.md, file2.md
**{Category 2}:** file3.md, file4.md
...
</reference_index>

<verification_criteria>
## Knowledge Quality Checklist

- [ ] All major libraries identified with adoption status
- [ ] Current versions verified (2024-2025)
- [ ] Decision guidance provided (when to use X vs Y)
- [ ] Complete lifecycle covered (not just "getting started")
- [ ] Platform-specific concerns addressed
- [ ] Anti-patterns documented
- [ ] Real-world patterns included
- [ ] No outdated/deprecated content
</verification_criteria>
```

## Step 6: Write Comprehensive References

For EACH reference file:

### Structure Template

```xml
<overview>
Brief introduction to this domain area
</overview>

<options>
## Available Approaches/Libraries

<option name="Library A">
**When to use:** [specific scenarios]
**Strengths:** [what it's best at]
**Weaknesses:** [what it's not good for]
**Current status:** v{version}, actively maintained
**Learning curve:** [easy/medium/hard]

```python
# Example usage
```
</option>

<option name="Library B">
[Same structure]
</option>
</options>

<decision_tree>
## Choosing the Right Approach

**If you need [X]:** Use [Library A]
**If you need [Y]:** Use [Library B]
**If you have [constraint Z]:** Use [Library C]

**Avoid [Library D] if:** [specific scenarios]
</decision_tree>

<patterns>
## Common Patterns

<pattern name="Pattern Name">
**Use when:** [scenario]
**Implementation:** [code example]
**Considerations:** [trade-offs]
</pattern>
</patterns>

<anti_patterns>
## What NOT to Do

<anti_pattern name="Common Mistake">
**Problem:** [what people do wrong]
**Why it's bad:** [consequences]
**Instead:** [correct approach]
</anti_pattern>
</anti_patterns>

<platform_considerations>
## Platform-Specific Notes

**Windows:** [considerations]
**macOS:** [considerations]
**Linux:** [considerations]
**Mobile:** [if applicable]
</platform_considerations>
```

### Quality Standards

Each reference must include:
- **Current information** (verify dates)
- **Multiple options** (not just one library)
- **Decision guidance** (when to use each)
- **Real examples** (working code, not pseudocode)
- **Trade-offs** (no silver bullets)
- **Anti-patterns** (what NOT to do)

### Common Reference Files

Most domains need:
- **architecture.md** - How to structure projects
- **libraries.md** - Ecosystem overview with comparisons
- **patterns.md** - Design patterns specific to domain
- **lifecycle.md** - Setup → dev → test → optimize → ship
- **testing-debugging.md** - How to verify correctness
- **performance.md** - Optimization strategies
- **deployment.md** - How to ship/distribute
- **anti-patterns.md** - Common mistakes consolidated

## Step 7: Create Workflows (Optional)

Domain expertise skills typically DON'T need workflows (they're knowledge bases).

**Only create workflows if:**
- Knowledge is complex enough to need structured consumption
- Different use cases need different subsets of references
- There's a natural "decision tree" for loading knowledge

Example: A complex domain might have:
```
workflows/
├── plan-new-project.md      # Which refs to load when planning
├── debug-existing.md         # Which refs help with debugging
└── optimize-performance.md   # Performance-specific references
```

Most domain skills skip this—references are self-sufficient.

## Step 8: Validate Completeness

### Completeness Checklist

Ask: "If create-plans loaded this to plan a {domain} project, would it have ALL the information needed?"

**Must answer YES to:**
- [ ] All major libraries/frameworks covered?
- [ ] All architectural approaches documented?
- [ ] Complete lifecycle addressed (not just "hello world")?
- [ ] Platform-specific considerations included?
- [ ] "When to use X vs Y" guidance provided?
- [ ] Common pitfalls documented?
- [ ] Current as of 2024-2025?

**Specific gaps to check:**
- [ ] Testing strategy covered?
- [ ] Debugging/profiling tools listed?
- [ ] Deployment/distribution methods documented?
- [ ] Performance optimization addressed?
- [ ] Security considerations (if applicable)?
- [ ] Asset/resource management (if applicable)?
- [ ] Networking/multiplayer (if applicable)?

### Verification Method

Run spot checks:
- Search "is {library} still maintained 2024"
- Check GitHub last commit dates for major libraries
- Verify version numbers in examples are current
- Confirm APIs haven't changed significantly

## Step 9: Create Directory and Files

```bash
# Create structure
mkdir -p ~/.claude/skills/expertise/{domain-name}
mkdir -p ~/.claude/skills/expertise/{domain-name}/references

# Write SKILL.md
# Write all reference files

# Verify structure
ls -R ~/.claude/skills/expertise/{domain-name}
```

## Step 10: Document in create-plans

Update `~/.claude/skills/create-plans/SKILL.md` to reference this new domain:

Add to the domain inference table:
```markdown
| "{keyword}", "{domain term}" | build/{domain-name} |
```

So create-plans can auto-detect and offer to load it.

## Step 11: Final Quality Check

Review entire skill:

**SKILL.md:**
- [ ] Name matches directory
- [ ] Description explains it's a knowledge base for other skills
- [ ] Reference index is complete and organized
- [ ] Verification criteria present

**References:**
- [ ] Pure XML structure (no markdown headings)
- [ ] Decision guidance in every file
- [ ] Current versions verified
- [ ] Code examples work
- [ ] Anti-patterns documented
- [ ] Platform considerations included

**Completeness:**
- [ ] A professional practitioner would find this comprehensive
- [ ] No major libraries/patterns missing
- [ ] Full lifecycle covered
- [ ] Passes the "plan a complex project" test

</process>

<success_criteria>
Domain expertise skill is complete when:

- [ ] Comprehensive research completed (5+ web searches)
- [ ] All sources verified for currency (2024-2025)
- [ ] Knowledge organized by domain areas (not arbitrary)
- [ ] Each reference has decision trees and comparisons
- [ ] Anti-patterns documented
- [ ] Full lifecycle covered (not just getting started)
- [ ] Platform-specific considerations included
- [ ] SKILL.md explains it's a knowledge base for other skills
- [ ] Located in ~/.claude/skills/expertise/{domain-name}/
- [ ] Referenced in create-plans domain inference table
- [ ] Passes completeness test: "Could create-plans build a comprehensive roadmap with just this knowledge?"
</success_criteria>

<anti_patterns>
**DON'T:**
- Copy tutorial content without verification
- Include only "getting started" material
- Skip the "when NOT to use" guidance
- Forget to check if libraries are still maintained
- Organize by document type instead of domain concerns
- Create a skill that executes tasks (this is knowledge only)
- Include outdated content from old blog posts
- Skip decision trees and comparisons

**DO:**
- Verify everything is current
- Include complete lifecycle
- Provide decision guidance
- Document anti-patterns
- Structure for consumption by other skills
- Make it exhaustive, not minimal
</anti_patterns>
