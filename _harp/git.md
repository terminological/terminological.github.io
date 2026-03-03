# Git cheatsheet

```gitconfig
ls = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate
ll = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat

```
[https://github.com/durdn/cfg/blob/master/.gitconfig](example gitconfig)


## The Ultimate Git Alias Setup

If you use git on the command-line, you'll eventually find yourself wanting aliases for your most commonly-used commands.  It's incredibly useful to be able to explore your repos with only a few keystrokes that eventually get hardcoded into muscle memory.

Some people don't add aliases because they don't want to have to adjust to not having them on a remote server.  Personally, I find that having aliases doesn't mean I that forget the underlying commands, and aliases provide such a massive improvement to my workflow that it would be crazy not to have them.

The simplest way to add an alias for a specific git command is to use a standard bash alias.

```bash
# .bashrc

alias s="git status -s"
```

The disadvantage of this is that it isn't integrated with git's own alias system, which lets you define git commands or external shell commands that you call with `git <alias>`.  This has some nice advantages:
- integration with git's default bash completion for subcommand arguments
- ability to store your git aliases separately from your bash aliases
- ability to see all your aliases and their corresponding commands using `git config`

If you add the following code to your .bashrc on a system with the default git bash completion scripts installed, it will automatically create completion-aware `g<alias>` bash aliases for each of your git aliases.

```bash
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion                                                                                                                                                                
fi


function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in `__git_aliases`; do
    alias g$al="git $al"
    
    complete_func=_git_$(__git_aliased_command $al)
    function_exists $complete_fnc && __git_complete g$al $complete_func
done
```

The main downside to this approach is that it will make your terminal take a little longer to load.

## My aliases

Here are the aliases I use constantly in my workflow.  I'm lazy about remembering many other aliases that I've decided I should be using, which this setup is great for because I can always list them all using `gla`.

```gitconfig
[alias]
    # one-line log
    l = log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short

    a = add
    ap = add -p
    c = commit --verbose
    ca = commit -a --verbose
    cm = commit -m
    cam = commit -a -m
    m = commit --amend --verbose
    
    d = diff
    ds = diff --stat
    dc = diff --cached

    s = status -s
    co = checkout
    cob = checkout -b
    # list branches sorted by last modified
    b = "!git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"

    # list aliases
    la = "!git config -l | grep alias | cut -c 7-"
```

See [Must Have Git Aliases](http://durdn.com/blog/2012/11/22/must-have-git-aliases-advanced-examples/) for more.