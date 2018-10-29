# kc

`kc` is a wrapper function around the `kubectl` command. It works in Bash. 

## Overview

`kc` is first and foremost a shortcut for the `kubectl` command. Type `kc <any
kubectl param>` and it will behave as you expect.

But if that's all it did, it would be pretty boring. And probably one character
too many ... `alias k=kubectl`.

Instead, `kc` allows you to easily incorporate the power of Bash to provide
further functionality and reductions by just writing specially named Bash
functions.

It also includes a set of default functions, primarily based on the "discovery"
sections of the official Kubernetes [cheat
sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/#viewing-finding-resources),
so hopefully those are useful.


## Installing

```
curl https://raw.githubusercontent.com/jar-o/kc/master/.kc > install.sh
chmod +x install.sh
./install.sh
```

## Using kc

As stated above, you can use `kc` as a shortcut to `kubectl`. But it also
includes a set of default functions that I've found useful and time saving. I
won't try to detail them here, but here's the help message, and you can do `kc
<function>` to find out more about each.

```
A shortcut and utilty for custom wrapped functionality around kubectl.
Usage: kc <custom function> <params ...>|<straight kubectl params ...>

Custom functions available:
    configmap
    context
    copy
    deploys
    desc
    events
    ingress
    namespaces
    nodes
    pods
    secret
    secretcompare
    secrets
    services
    shell
    slogs
(If no function is matched above, params will be sent straight to kubectl.)
```

I find the `secretcompare` function quite useful if you use a staging/prod
environment with identical deployments but different secrets. You should check
that one out at least.

## Adding your own functions.

When `kc` is installed, it creates two files:

```
$HOME/.kc
$HOME/.kc_custom
```

The `.kc` file contains all the default functions, and it's best not to modify
that one, in case in the future you ever want to update `kc`. However, the
`.kc_custom` file exists for user modifications. So to add a function, simply
edit `.kc_custom` with your new function, prefixed by `kc-`, save, and source
`$HOME/.kc`.

E.g. to do the time-honored *Hello World* function, you'd add

```
function kc-helowrld {
	echo "helowrld"
}
```

to `.kc_custom`, save, and then `source $HOME/.kc`. Now when you run `kc`
you'll see `helowrld` under the `Custom functions available` section. Note that
you don't invoke with the `kc-` prefix. That's just so the `kc` function can
automatically discover your functions without any help from you. Just do `kc helowrld`.

## Overriding the kc default functions

The `~/.kc_custom` file is sourced at the end of `~/.kc` which means it's easy to
override any of the included functions. E.g. if you want JSON output for say
`kc-configmap` instead of the default YAML, just copy-paste the existing
function into `~/.kc_custom` and save:

```
function kc-configmap {
	kubectl ... -o json
}
```

Now, after you source `~/.kc` the `kc-configmap` from `~/.kc_custom` will be
executed instead of the default `kc-configmap`.

## Motivation

While most `kc` invocations are typing savers compared to the equivalent
`kubectl` command -- and that was part of the point of having a shortcut -- the
other reason was the [Pareto
principle](https://en.wikipedia.org/wiki/Pareto_principle) and muscle memory.

As with so many other things, I found that I use a subset of `kubectl`
invocations far more than others (like the "discovery" ones), and while I want
to save keystrokes, I also found that consistently typing those commands made
me faster at them. Hence enforcing strict "parameter placement" on the
customized `kc` functions. For instance, you'll notice that `namespace` is
always the first param when it's required in a `kc` custom function, whereas
with `kubectl` you can specify `-n <namespace>` ahead or behind other params.
