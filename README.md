# Applied Data Science Portfolio README.md
## By William D. Lombardi

The theme I currently using is '__jekyll-theme-console__'. According to the creator of this theme, this was created with an inspiration from linux consoles for hackers, developers and script kiddies.

Here is a Screenshot of example of what the theme is capable of:
<img src="https://raw.githubusercontent.com/b2a3e8/jekyll-theme-console/master/screenrec-dark.gif" width="550" title="Screenshot">

## Installation
In order to install this theme do the following steps:
_STEP 1:_ Add this line to your Jekyll site's `Gemfile`:
```ruby
gem "jekyll-theme-console"
```
_STEP 2:_ Add this line to your Jekyll site's `_config.yml`:
```yaml
theme: jekyll-theme-console
```
_STEP 3:_ Then execute:
    $ bundle
Or install it yourself as:
    $ gem install jekyll-theme-console

## Usage
In addition to the jekyll's default configuration options, you can provide:
- `header_pages` to specify which pages should be displayed in navbar
- `footer` string, which will be inserted on the end of the page (doesn't support markup, but html)
- `google_analytics` tracking id (tracking will be enabled only in production environments)

```yaml
header_pages:
  - index.md
  - /Big-Data-Analytics/about-course.md
style: dark # dark (default) or light
footer: 'follow me on <a href="https://twitter.com/dougielombardi">twitter</a>'
google_analytics: UA-140773849-1
```
As you can see, I am still working on this part of the site. I am trying to figure out the navbar. If you have worked on this Jekyll theme before and know how to work out the navbar, feel to contact me [_here_](https://www.williamdlombardi.com/contact-wdl).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/b2a3e8/jekyll-theme-console. This theme is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Development
To set up your environment to develop this theme, run `bundle install`.

This theme setup is just like a normal Jekyll site! To test your theme, run `bundle exec jekyll serve` and open your browser at `http://localhost:4000`. This starts a Jekyll server using your theme. Add pages, documents, data, etc. like normal to test your theme's contents. As you make modifications to your theme and to your content, your site will regenerate and you should see the changes in the browser after a refresh, just like normal.

When the theme is released, only the files in `_layouts`, `_includes`, `_sass` and `assets` tracked with Git will be bundled.

To add a custom directory to your theme-gem, please edit the regexp in `jekyll-theme-console.gemspec` accordingly.

## License
The '__jekyll-theme-console__' theme is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
