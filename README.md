# lighthouse-server-heroku

Lighthouse server running on Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/browniebroke/lighthouse-server-heroku)

## Adding a project

To register a project with this CI server, you need to create it via the LH CLI Wizard:

```bash
heroku run lhci wizard
```

Answer the questions when prompted and keep the build token where you run Lighthouse.

## Database Tier

The app will be provisioned with a free DB tier, which is limited to 10,000 rows, and this limit is reached pretty quickly. However, a script to purge runs older than 7 days is provided: `purge-runs.sh`, which you can run on a schedule using the Heroku scheduler add-on, which is also provisioned by default.

Open the scheduler add-on in the Heroku dashboard and add a job running `purge-runs.sh` to run every day. This will purge all runs older than a week.
