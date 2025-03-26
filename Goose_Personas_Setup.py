import os
import platform
import subprocess

def is_git_repo():
    """Check if the current directory is a Git repository."""
    return os.path.isdir(".git")

def pull_latest_changes():
    """Pull the latest changes from the Git repository."""
    response = input("Do you want to pull the latest changes from the repository? (y/n): ").strip().lower()
    if response in ["y", "yes"]:
        print("Pulling the latest changes...")
        try:
            subprocess.run(["git", "pull"], check=True)
        except subprocess.CalledProcessError:
            print("Error: Failed to pull changes.")
            exit(1)
    elif response in ["n", "no"]:
        print("Skipping the pull. Using the current state of the directory as-is.")
    else:
        print("Invalid input. Exiting.")
        exit(1)

def generate_memory_instructions():
    """Generate memory instructions for each persona."""
    memory_instructions = []
    
    for file_name in os.listdir(os.getcwd()):
        if file_name.endswith(".md"):
            if file_name == "README.md":
                continue
            
            # Convert file name to persona name
            persona_name = os.path.splitext(file_name)[0].replace("_", " ").title()
            file_path = os.path.abspath(file_name)
            
            memory_instructions.append(f"Remember that persona: '{persona_name}' is defined in the file: '{file_path}'")

    # Add default persona instructions
    memory_instructions.append("Remember the 'Default' persona represents Goose’s unrestricted, general-purpose functionality.")
    memory_instructions.append("Review each persona's file contents and add its use cases to the memory.")
    memory_instructions.append("Store all of these memories globally with appropriate tags.")
    memory_instructions.append("Remember when switching personas, identify very briefly its capabilities and provide a short list of ways that the user can get started.")

    return "\n".join(memory_instructions)

def execute_instructions(memory_instructions):
    """Simulate executing the instructions in Goose."""
    command = ["goose", "run", "-t", memory_instructions]
    try:
        subprocess.run(command, check=True)
    except subprocess.CalledProcessError:
        print("Error: Failed to execute Goose instructions.")
        exit(1)

def main():
    print("Starting Goose Personas Setup Script...")

    # Step 1: Check for Git repository and pull latest changes if applicable
    if is_git_repo():
        pull_latest_changes()
    else:
        print("Warning: This does not appear to be a Git repository. Proceeding with the current files in the directory.")

    # Step 2: Generate memory instructions
    print("Generating instructions for memory mappings...")
    memory_instructions = generate_memory_instructions()
    print("Memory instructions generated.")

    # Step 3: Execute instructions in Goose
    print("Executing instructions in Goose...")
    execute_instructions(memory_instructions)

    print("Goose instructions executed. All mappings should now be in place! Double check goose memories to confirm.")

if __name__ == "__main__":
    main()