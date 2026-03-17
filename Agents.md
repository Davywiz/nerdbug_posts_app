# AGENTS.md

This repository is a Flutter assessment project for Nerdbug.

Goal:
Build Question 1 from the assessment:
- Fetch posts from https://jsonplaceholder.typicode.com/posts
- Display the list of posts
- Show post details
- Implement loading and error states
- Allow users to mark posts as favorites
- Use proper state management
- Keep the UI clean and responsive

Technical constraints:
- Use Flutter
- Use flutter_riverpod for state management
- Use dio for API calls
- Keep architecture simple and readable
- Do not overengineer the solution
- Do not add unnecessary features like auth, pagination, search, or animations unless explicitly requested
- Prefer a clean folder structure
- Use null safety
- Keep code production-like and interview-friendly

Suggested structure:
lib/
  main.dart
  app.dart
  core/
  features/
    posts/
      data/
      presentation/

Quality bar:
- Clean, readable code
- Small reusable widgets where helpful
- Proper loading, error, and empty states
- Responsive layout
- Clear README

Commands to run:
- flutter pub get
- flutter analyze
- flutter test

Important:
- Make changes in small phases
- At the end of each phase, summarize what changed
- Do not make giant sweeping edits unless asked
- Keep commit boundaries logical so the repo history can show meaningful progress