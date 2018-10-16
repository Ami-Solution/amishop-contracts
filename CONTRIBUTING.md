# How to contribute

I'm really glad you're reading this, because we need volunteer developers to help this project come to fruition.

If you haven't already, come find us in Slack ([Amisolution Slack](https://amisolution.slack.com). We want you working on things you're excited about.

Here are some important resources:

  * [Amis-erc20 Slack](https://amisolution.slack.com). We're usually there during business hours.
  * [SubReddit](https://www.reddit.com/r/amis_erc20/)
  * [Medium blog](https://medium.com/@amis_erc20) is where we explain our project and do announcements
  * [Twitter](https://twitter.com/amis_erc20) to follow us
  * [Facebook](https://www.facebook.com/amis.token/) to follow us

  * Non critical Bug? [Github issue](https://github.com/ami-solution/amishop/issues) is where to report them

## Testing

We are testing the smart contracts with Javascript in async/await style, and the Truffle framework to run them. Please write test examples for new code you create.

## Submitting changes

Please send a [GitHub Pull Request to Dether](https://github.com/ami-solution/amishop/pulls) with a clear list of what you've done (read more about [pull requests](http://help.github.com/pull-requests/)). When you send a pull request, we will love you forever if you include tests. We can always use more test coverage. Please follow our coding conventions (below) and make sure all of your commits are atomic (one feature per commit).


### Commit guidelines

```
git checkout -b feature/...
git checkout -b fix/...
```

```
[ADD] new file/function/feature
[UPD] update file/function/feature
[UPG] upgrade dependency
[ARC] refactor part of the project
[DEL] remove file/function/feature
[WIP] work in progress
```

```
git checkout develop
git merge origin feature/...
git merge origin fix/...
```

Always write a clear log message for your commits. One-line messages are fine for small changes, but bigger changes should look like this:

    $ git commit -m “[???] A brief summary of the commit
    >
    > A paragraph describing what changed and its impact.”



## Coding conventions

Start reading our code and you'll get the hang of it. We optimize for readability:

  * We indent using two spaces (soft tabs)
  * We use async/await for tests
