# ChecklistValidator
Ensures that all items on the checklist are completed.

## Usage
Create a pull request containing the checklist

It would be useful to create a template

### checklist md
```md
- [x] todo1
- [ ] todo2
- [ ] todo3
```

### Specify in actions

```yml
name: PR Checklist Validation

on:
  pull_request:
    types: [opened, edited, reopened, synchronize]

jobs:
  validate-checklist:
    runs-on: ubuntu-latest

    steps:
      - name: Check out the repository
        uses: actions/checkout@v4

      - name: Validate PR checklist
        uses: Pianoopera/ChecklistValidator@v2.1
        with:
          github_token: ${{ github.token }}
```

The GitHub token used for authentication. Typically, this is specified as `${{ github.token }}`.
