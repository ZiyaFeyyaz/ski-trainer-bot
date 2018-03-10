# Example telegram bot app

Bot name is [@SkiTrainerBot](https://telegram.me/SkiTrainerBot)

This app uses [telegram-bot](https://github.com/telegram-bot-rb/telegram-bot) gem.

## Commands

- `/start` - Registration.
- `/help` - Show help info.
- `/trainings` - Show trainings list by the selected training plan.

## Setup

- Create bot with [@BotFather](https://telegram.me/BotFather)
- Clone repo.
- run `./bin/setup`.
- Update `config/secrets.yml` with your bot's token.

## Run

### Development

```
bundle exec rake telegram:bot:poller
```

### Production

There is better way: use webhooks. Check your production secrets and configs.

```
bundle exec rake telegram:bot:set_webhook RAILS_ENV=production
bundle exec rails server
```

### Testing

