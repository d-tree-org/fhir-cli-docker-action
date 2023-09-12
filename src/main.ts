import * as core from "@actions/core";
import * as github from "@actions/github";
import { Inputs, Reposter } from "./repost-comment";

async function main(): Promise<void> {
  try {
    if (github.context.payload.pull_request) {
      const inputs: Inputs = {
        checkOnlyFirstLine: core.getInput("check-only-first-line") === "true",
        comment: `
        ## Test comment
        `,
        unique: core.getInput("unique") === "true",
        number: github.context.payload.pull_request.number,
        repository: core.getInput("repository", { required: true }),
        token: core.getInput("token", { required: true }),
      };

      const reposter = new Reposter(inputs);
      await reposter.repostComment();
      core.setOutput("success", true);
    }
  } catch (error: any) {
    core.setFailed(error.message);
  }
}

main();
