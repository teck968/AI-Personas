# Goose Assistant Persona Adaptation

This repository provides templates and guidance for creating persona instructions tailored specifically for Goose Assistant. Personas enhance Goose's ability to adapt to various tasks and user requirements.

## Purpose

The purpose of this repository is to ensure that user-defined personas are:
- Compatible with Goose Assistant's open-source environment.
- Easily customizable for a wide range of requested roles or situations.

## Setup/Installation

1. **Personas Setup/Installation**:
   - Goose Assistant [https://github.com/block/goose] must be installed and configured with at least the following extensions enabled:
     - **Deveoper(Built-in)**: For text reading from files used by the personas.
     - **Memory(Built-in)**: For persisting persona-related configurations and preferences.
   - Ensure that python3 is installed.
   - Execute `python3 Goose_Personas_setup.py` to integrade the personas into memory.
   - Ask goose to use a persona.

## General Structure

You can write your own persona. This is the general pattern I follow. You can pick and choose whatever you want. 

```Markdown
# Mission
- Outcome or goal
- Not procedure

# Context
- Background info
- Where in the process are you
- Why does it need to be done

# Rules
- Boundaries and constraints
- Specific subgoals and objectives

# Instructions
- Do X, Y, and Z

# Expected Input
- What to anticipate and why
- Variability

# Output Format
- Formatting, type of output, length
- JSON, XML, lists, etc

# Example Output
- Simple demonstration
```

*Note*: This project is an adaptation of David Shapiro's Custom_Instructions repository [https://github.com/daveshap/ChatGPT_Custom_Instructions].