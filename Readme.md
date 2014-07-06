# View Ruby Regexes

Create railroad diagrams for Ruby regexes.

## Intent
I love the [Regexper](http://www.regexper.com/#%2Fa%5Bbc%5Dd%2F) app.
But I am pretty sure it is for JavaScript regexes.
At the very least, it's not too hard to craft a regex that
it is unable to process.
[This one](https://github.com/ruby/ruby/blob/92089610b617fc07084d03f24a3e58a40639e5ce/lib/shellwords.rb#L73)
for example.

## How it will work
1. Take the regex, pass it to a shitty binary I wrote that hooks into [Oniguruma](http://www.geocities.jp/kosako3/oniguruma/) and spits out a shitty tree view (read more about that in Current State, below)
2. Parse the tree to get the relevant data
3. Convert it to the same server response that Regexper gives to its JavaScript
4. Let Regexper's awesome JS make the thing viewable
5. Put it on the internetz somewhere

## Current state
All it does at present is takes a regex and spits out a shitty tree view.
It does this by basically just uncommenting Oniguruma's debug flags
which spit out a tree view for debugging.

I spent like 6 hours going through this shit trying to figure out how it works
and I have a slight bit of an idea now (when I started, I didn't even
know how to talk to the thing from my program). And I still don't actually
know how to (1) traverse the tree to print out a less shitty version
(2) get access to the node tree from my code (it gets compiled immediately
and the node tree is never exposed to me -- I don't know how to interrupt
the process so I can access the tree).

So it is shitty because it hacks the Oniguruma source code itself rather than
sitting outside of it and interacting with it via the interface.

It is also shitty because this debugging view was not intend for this purpose,
it was just to give the devs a visualization of what was happening.

Anyway, the program that interacts with it is taken from
[here])(http://www.geocities.jp/kosako3/oniguruma/sample/simple.c).
It is the sample program that is an "example of the minimum"
but I changed it slightly, too, to allow the regex to be passed
in on the command line.

I did edit the lib to print out delimiters around the tree
so that I can extract it from anything else that might be printed.

## "Plan" (If I decide to keep working on it)
* MVP
  * Parse a simple example of its output
  * Turn that into Regexper language
  * Replace [this](https://github.com/javallone/regexper/blob/caa8c03d9127c0c7db1139299c7f756f6edeff80/config.ru#L39) line with my output
  * See that it works in the browser
* Something slightly more realistic.
  * Look through [this](https://github.com/javallone/regexper/blob/caa8c03d9127c0c7db1139299c7f756f6edeff80/lib/regexper/modules.rb) and make sure I understand what I need to provide in the API
  * Look through the list of node types in Oniguruma and make sure I can parse all nodes
  * Bombard it with a shitload of tests and make sure it does the right thing
  * Inevitably it won't, in which case, figure out how to configure Oniguruma to do what Ruby does (is there a Ruby config for it somewhere?)
* For public consumption
  * Rename it
  * Rebrand it
  * Host it somewhere
  * Bask in all the glory of nobody giving a shit

## Alternatives considered
I could have tried to use something like [RegexpParser](http://rubygems.org/gems/regexp_parser)
but that approach seems more flawwed to me than the terrible hack that I've made
since it relies on a separate parser (ragel).
It seems like it will inevitably have differences, and in this case, it seems that
it has [not been updated](https://github.com/ammar/regexp_parser/commit/2c8c1cc524a9ed5797d8a3d5acc09c66b6735ffc)
to make sure it is compatible with Ruby 2+.

I could have tried to adapt the [Regexper parser](https://github.com/javallone/regexper/blob/caa8c03d9127c0c7db1139299c7f756f6edeff80/lib/regexper_parser.treetop)
which would have made it trivial to integrate with Regexper's JS side.
But again, a non-canonical parser which would likely be divergent on some point,
and require a lot of effort to keep current.
And I'd have to implement it myself, which I doubt I'm good enough to do.

Frankly, I'd like Oniguruma to give me access to the unoptimized uncompiled node
tree, so I can sit outside it and maybe make it available to Ruby via a C extension
rather than a command line interface. But I'm pretty sure that's not going to happen.

## License
Oniguruma is [BSD license](https://en.wikipedia.org/wiki/BSD_License#4-clause_license_.28original_.22BSD_License.22.29).
Regexper is [Creative Commons](http://creativecommons.org/licenses/by-nc-sa/3.0/).
I'll make mine [WTFPL](http://www.wtfpl.net/).

This applies only to the code I write that sits outside of Oniguruma and Regexper (I haven't done anything w/ Regexper yet).
The code inside them inherits whatever their licenses say they do.


```
        DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.
```
