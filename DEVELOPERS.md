# Developing Launchpad

- [Developing Launchpad](#developing-launchpad)
  - [Getting started](#getting-started)
    - [Install dependencies](#install-dependencies)
  - [Local development](#local-development)
    - [Fork the repo](#fork-the-repo)
    - [Clone the repo](#clone-the-repo)
    - [Install dependencies](#install-dependencies)
    - [Get Started](#get-started)
  - [Create a pull request](#create-a-pull-request)
  - [Issue assignment](#issue-assignment)

## Getting started

Thank you for your interest in Launchpad and your willingness to contribute!

We encourage you to explore the existing [issues](https://github.com/NorkzYT/Launchpad/issues) to see how you can make a meaningful impact. This document will help you setup your development environment.

### Install dependencies

You will need to install and configure the following dependencies on your linux machine:

- [Git](http://git-scm.com/)
- [Node.js v18.x (LTS)](http://nodejs.org)
- [npm](https://www.npmjs.com/) latest
- [Bun](https://bun.sh/) latest (Install with `npm install -g bun`)
- [GNU Make](https://www.gnu.org/software/make/) latest (Install with `sudo apt-get install make -y`).
- [OpenCommit](https://github.com/di-sukharev/opencommit) latest (Install with `npm install -g opencommit`).

## Local development

### Fork the repo

To contribute code, you must fork the [Launchpad repo](https://github.com/NorkzYT/Launchpad).

### Clone the repo

1. Clone your GitHub forked repo:

   ```sh
   git clone https://github.com/<github_username>/Launchpad.git
   ```

2. Go to the Launchpad directory:
   ```sh
   cd Launchpad
   ```

### Install dependencies

1. Install the dependencies in the root of the repo.

   ```sh
   bun run clean:install # install dependencies
   ```

#### Get Started

1. Run the following command to setup all environments.
   ```sh
   make setup # setup all environments
   ```

## Create a pull request

After making any changes, open a pull request. Once you submit your pull request, @NorkzYT will review it with you.

## Issue assignment

We do not have a process for assigning issues to contributors. Please feel free to jump into any issues in this repo that you are able to help with. Our intention is to encourage anyone to help without feeling burdened by an assigned task. Life can sometimes get in the way, and we do not want to leave contributors feeling obligated to complete issues when they may have limited time or unexpected commitments.

We also recognize that not having a process can sometimes lead to competing or duplicate PRs. There's no perfect solution here. We encourage you to communicate early and often on an Issue to indicate that you're actively working on it. If you see that an Issue already has a PR, try working with that author instead of drafting your own.

We review PRs in the order of their submission. We try to accept the earliest one that is closest to being ready to merge.
