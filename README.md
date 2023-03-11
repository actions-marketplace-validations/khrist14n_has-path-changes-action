# has-path-changes-action
Github action for checking if a path in the repo has changes.


## Why?

This is useful for things like checking if you need to open a pull
request for any changes that may be introduced through another action in a path for your workflow

## How?

Add a step in a job after any steps whose path changes you want to check.

You will then be able to check the status in subsequent steps.

You do this by checking if `changed` is equal to `1`.

The value will be 0 if no code has been changed by any previous steps.

## Example

```yaml
name: Has Path Changes
jobs:
  has-changes:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
      with:
        ref: ${{ github.head_ref }}
    - name: Make changes
      run: |
        mkdir -p changes_path
        touch changes_path/change.temp

    # This step will evaluate the path of the repo status and report the change
    - name: Check if there are changes
      id: changes
      uses: khrist14n/has-path-changes-action
      path: changes_path

    # You can now access a variable indicating if there have been changes
    - name: Process changes
      if: steps.changes.outputs.changed == 1
      run: echo "Changes exist"
```

The example shows that adding a step to check the status will expose the status on the `${{ steps.changes.outputs.changed }}` variable.

The `steps.changes` is defined by the `id: changes`. If you chan ge the id value then the step name must change too (as it references the id).

