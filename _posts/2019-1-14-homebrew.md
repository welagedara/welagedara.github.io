---
layout: post
title: "Getting Started with Homebrew"
categories: junk
author: "Pubudu Welagedara"
meta: "Homebrew"
comments: true
---

[Homebrew][homebrew] is an Open Source Package Manager for macOS. 

To create your first formula create a Repository on GitHub. Set the visibility to public while doing so.

First [create a new GitHub Repository][create_new] for your Formula. You can use the Web Interface or the CLI for this. I am using the CLI just for fun( Replace `pwelagedara` with your Username and `hello` with your repository name in all my commands).


```bash
curl -u 'pwelagedara' https://api.github.com/user/repos -d '{"name":"hello"}'
git init
sudo nano hello
```

Add the Ruby Script below and save it( CTRL + X and then y) to save).

```ruby
#!/usr/bin/env ruby

puts "Hello...!!!"
```

Next make the file an executable. Push it to GitHub. Tag it and then push the Tag.

```bash
# Set the permissions
sudo chmod +x ./hello

# Check if the script works. The script should print "Hello...!!!"
./hello 

# Push the code
git add -A
git commit -m "initial commit"
git remote add origin https://github.com/pwelagedara/hello.git
git push origin -u master

# Tag the relase and push it
git tag v1.0.0
git push origin v1.0.0
```

Under `release` tab in your GitHub Repository find the link to download `*.tar.gz` file of the release. Copy that link.

{% assign image = "release.png" %}
{% assign alt = "GitHub Release" %}
{% include srcset.html %}

Now use the below commands to create the Formula. Make sure you know where the file got saved because you will need that for your Homebrew Tap( 3rd Party Repo).

```bash
brew create https://github.com/pwelagedara/hello/archive/v1.0.0.tar.gz
```

In a new Directory create another Repository for the Tap. Remember that you need to prefix your Repository name with `homebrew-`.

```bash
curl -u 'pwelagedara' https://api.github.com/user/repos -d '{"name":"homebrew-tap"}'
git init

# The first argument is the location of the file you saved
mv /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/hello.rb ./
sudo nano ./hello.rb
```

Edit the file to look like below.

```ruby
class Formula < Formula
  desc ""
  homepage ""
  url "https://github.com/pwelagedara/hello/archive/v1.0.0.tar.gz"
  sha256 "3b8c437f71f6c9a9ce8002683a96783296e743c019b2a882b0e62ddd102f6ffb"

  def install
    bin.install "hello"
  end
end
```

Now push the files to the GitHub Repository.

```bash
git add -A
git commit -m "initial commit"
git remote add origin https://github.com/pwelagedara/homebrew-tap.git
git push origin -u master
```

Now you can test it. If you have done everything right the last command will print "Hello...!!!".

```bash
brew tap pwelagedara/tap
brew install hello
hello
```
The Source Code of the above Projects is available on my [GitHub][github].

[homebrew]: https://brew.sh/
[video_tutorial]: https://www.youtube.com/watch?v=fbyrLo6yx8M
[create_new]: https://help.github.com/articles/creating-a-new-repository/
[github]: https://github.com/pwelagedara/






























