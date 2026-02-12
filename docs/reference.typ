#let typst-toml = toml("../typst.toml")

#let doc = (
  title: [The #raw(typst-toml.package.name, lang: "typst") Reference],
  package-name: typst-toml.package.name,
  package-version: typst-toml.package.version,
  author: typst-toml.package.authors.join(", "),
  license: typst-toml.package.license,
  description: typst-toml.package.description,
  keywords: typst-toml.package.keywords,
  categories: typst-toml.package.categories,
  //disciplines: typst-toml.package.disciplines,
  date: datetime.today(),
)

#let fonts = (
  headings: "Fira Sans",
  text: "Gentium",
  code: "Fira Mono",
)

#let colors = (
  title: rgb("#361c0d"),
  links: rgb("#52a"),
  headings: black,
  footer: gray,
  package-name: rgb("#563c2d"),
)

#let pkg = text(font: fonts.code, weight: 500, size: 0.9em, fill: rgb("#563c2d"), raw(typst-toml.package.name, lang: "typc"))


#set document(
  title: doc.title,
  author: doc.author,
  description: doc.description,
  keywords: doc.keywords,
  date: doc.date,
)

#set par(justify: true)
#set text(font: fonts.text)
#set page(
  margin: (top: 20mm, bottom: 20mm),
  numbering: "1"
)

#show raw: set text(font: fonts.code)
#set raw(lang: "typc")
#show raw: it => highlight(fill: rgb("#f2f2f2"), extent: 0.05em, it)

#show link: set text(fill: colors.links)
#show link: it => [#it#text(super("⮥"), fill: colors.links.transparentize(75%))]

#show heading: set text(
  font: fonts.headings,
  fill: colors.headings,
)
#set heading(numbering: "1.1")

#show title: set text(
  font: fonts.headings,
  fill: colors.title,
  size: 20pt
)

#title()

#outline()

#pagebreak()
= Introduction

#pagebreak()
= Gross anatomy of a letter <gross-anatomy>

A letter consists of different parts and components, many of which are
configurable and follow various rules depending on language, locality, etc.
The purpose of this section is to describe and illustrate the different
components of a #pkg letter with their various options and usage considerations.

While various configuration options are mentioned, this section is not about the
API, but about the range of these options, their effects, and any considerations
around using them. For a detailed documentation of the API, see @api-reference.

@letter-parts-illustrated below illustrates the major components of a letter.
This is followed by subsections describing each of these components in more detail.

#figure(
  image("./letter-parts.svg", height: 75%),
  caption: [The major parts of a letter illustrated]
) <letter-parts-illustrated>


== The letterhead

Positioned at the top of the page, the *letterhead* contains the sender's
details such as name and contact details, as well as optional decorative
elements such as a logo or a monograph.

=== Subcomponents of the letterhead

By default, the letterhead is made up of the following subcomponents
(illustrated in @letterhead-subcomponents), populated
with the information passed via the `author` argument to #pkg:
- The _headline_ is set in maroon spaced small caps and contains the
  content of `author.name`.
- The _author's address_ is set immediately below the headline and contains
  the concatenated information from `author.address`, separated by
  inline bullet points.
- The _further contact details_ are set below this, and include (if provided)
  the phone number (`author.phone`), e-mail address (`author.email`), and
  website address (`author.web`) in that order. If two of these are specified,
  they are shown separated by an inline bullet point. If all three are
  specified, the website address is set on a separate line below the other two.
- A _logo_ or monogram can be included if specified with the `logo` argument,
  the placement of which depends on the letterhead alignment (for more info,
  see @letterheads-with-logos).

#figure(
  image("./letterhead-content-parts.svg"),
  caption: [Subcomponents of the letterhead]
) <letterhead-subcomponents>

If you want to customise the letterhead beyond the options discussed here, you
can also overwrite it completely by passing a #link("https://typst.app/docs/reference/foundations/content/")[content] argument via `style.components.letterhead.content`.
If you do this, #pkg only configures the letterhead dimensions and leaves
everything else to you.

If you want to not display a letterhead at all, you can set `style.components.letterhead.content` to `none`. This will completely deactivate the letterhead, and set the top margin of the page to `style.page.margins.top` (compare this to the behaviour of the top margin when a
letterhead is present, described in the next section).

=== Letterhead dimensions

The dimensions of the letterhead are shown in @letterhead-dimensions below.
By default, the letterhead has a _header height_ of 27mm, starting from the top
of the page. It is extended by 5mm (to 32mm in total) if the letterhead includes
a logo  and the horizontal alignment is `center`.
The letterhead is itself positioned in the page's _top margin_, which by
default is 37mm high. The distance between the bottom of the header and the end
of the top margin is the _header ascent_, which is 10mm by default, reducted to
5mm if there is a logo in the letterhead. To the sides, the letterhead is
bounded by the page's _left margin_ and the page's _right margins_.

#figure(
  image("./letterhead-dimensions.svg"),
  caption: [Dimensions of the letterhead]
) <letterhead-dimensions>

The header dimensions are determined as follows:
- `style.components.letterhead.height` sets the _header height_.\
  Default: 27mm if no logo is set, 32mm if a logo is set and the
  horizontal alignment is `center`.
- `style.components.letterhead.ascent` sets the _header ascent_.\
  Default: 10mm if no logo is set, 5mm if a logo is set and the
  horizontal alignment is `center`.
- The _top margin_ on a page is set to the sum of
  `style.components.letterhead.height + style.components.letterhead.ascent`,
  which overwrites `style.page.margins.top` if and only if the page has a
  letterhead. 
- The _left margin_ and _right margin_ are set by `style.page.margins.left` and
  `style.page.margins.right`.\
  Default: 25mm for both.

=== Letterhead alignment

By default, the content of the letterhead is aligned `center + bottom`. The
bottom alignment means that it grows upwards as more information is added.

The alignment of the letterhead can be configured via `style.alignment.letterhead`
and may consist either only of a horizontal alignment, only of a vertical
alignment, or both.

The horizontal alignment options, illustrated in @letterhead-horizontal-alignment
below, are as follows:
- `left`: Align the letterhead content to the left.
  If applicable, the logo is placed to the left side of the remaining content.
- `right`: Align the letterhead content to the right.
  If applicable, the logo is placed to the right side of the remaining content.
- `center`: Align the letterhead centred between the left and right margins.
  If applicable, the logo is centred on top of the remaining content.

#figure(
  image("./letterhead-horizontal-alignment.svg"),
  caption: [Horizontal alignment options for the letterhead]
) <letterhead-horizontal-alignment>

The vertical alignment options, illustrated in @letterhead-vertical-alignment
below, are as follows:
- `top`: Align the letterhead's content to the top. As more content is added, it
  grows downwards.
- `horizon`: Align the letterhead's content vertically centred. As more content
  is added, it grows both upwards and downwards equally.
- `bottom`: Align the letterhead's content to the bottom. As more content is
  added, it grows upwards.
- *Note:* if a logo is specified and the horizontal alignment is `center`, then
  the vertical alignment is always `bottom`, and attempting to set it to a
  different value will have no effect.

#figure(
  image("./letterhead-vertical-alignment.svg"),
  caption: [Vertical alignment options for the letterhead]
) <letterhead-vertical-alignment>

=== Letterheads with logos <letterheads-with-logos>

The default letterhead has been designed to emit a somewhat understated
traditional flair by itself. But if desired, a small logo or monogram graphic
can be included by specifying the `logo` argument when initiating #pkg.

If you include a logo, you should keep in mind that the overall dimensions of
the letterhead are quite constraint and the maximal letterhead height should not
exceed 32mm including both the logo and any text contained within it. This means
it is important to carefully size your logo to harmonize with the remainder of
the letterhead's content. Between 10 and 15mm is usually a good guide for the
height of the logo; there is more flexibility with regard to the width.

As dicussed under alignment above, the placement of the logo depends on the
letterhead alignment. The effect of the various options are illustrated in
@letterhead-logo-alignment below.

#figure(
  image("./letterhead-logo-alignment.svg"),
  caption: [Alignment of letterheads with logos/monograms]
) <letterhead-logo-alignment>

Note how the `center`-aligned header with a logo in @letterhead-logo-alignment
has been automatically vertically expanded by 5mm, which gives it a little more
space to accommodate the logo above the text.

It should also be noted that, by default, the logo is inserted _without any
additional padding or spacing_ around it. This is so that you can best tweak the
logo to integrate well with the remaining letterhead content. If you want padding
around the logo, either include the padding in the image file itself or wrap it
in a call to #link("https://typst.app/docs/reference/layout/pad/")[`pad(...)`].

=== Letterheads and multipage documents

By default, #pkg only displays the letterhead on the first place of a multipage
document. However, provided that the letterhead is fairly minimalistic, it can
look fairly neat to have the letterhead repeated across all the pages
of a letter. If this is desired, the  `style.page.repeat-letterhead` can be set
to `true` to enable repetition of the letterhead across all pages.

It is never wrong to only have the letterhead feature on the first page, whether
it is quite simple or more complex. However, due consideration must be applied
if a more complex header is to be repeated: generally speaking, most letterheads
with more than three lines of text (including the headline) or with a logo in
them look out of place when repeated across pages.

== The address field

The *address field* contains the name and address of the letter's intended
(primary) recipient. Depending on the locale, it may include a
_return address field_, which is discussed separately in @return-address-field.

== The return address field <return-address-field>

The *return address field* is a small sub-field of the address field which
usually contains a return address to be used in case there are issues with
delivering a letter.

The return address field is only used in some countries, and primarily intended
to work in tandem with windowed envelopes, so that the address field and the
return address field are visible through a window in the envelope. The return
address field can also contain some notes for delivery and has a secondary
function of giving the recipient an idea of the letter's origin before they
open it.

== The reference field

The *reference field*: this is an optional field that can be used to quote a reference
  number, such as a case number or an insurance policy number, which is intended to help
  the recipient in quickly identifying what matter the correspondence relates to.
  This is mainly used when corresponding with larger businesses, insurance providers, government departments, and similar institutions.

  In business-to-business communication you may see letters with two such fields
  (usually labelled something like "Our ref:" and "Your ref:"), but because #pkg
  is intended primarily for personal correspondence, it implements only a single
  reference field.

== The date field

The *date field*: as the name suggests, this is used to give the date on which the
  letter was written. Depending on the langauge and country, this may also include
  the place where a letter was written (for example, in Germany and France it is
  typical to write something like "Hamburg, the 1st of April 2026").

== The text body

The *text body*: this is where the main content of the letter goes, and it has
  its own structure and conventions. It includes things such as the _salutation_
  (sometimes called _greeting_), and may include a subject line and optional
  sub-headings along with one or more paragraphs of text.

== The valediction
The *valediction*: sometimes called a _closing formula_ is the conventional way
  to end a letter. It typically includes a complimentary phrase, such as
  "Yours faithfully" (this is the actual _valediction_) and the author's signature
  and name.

== The _cc_ field

The *_cc_ field*: short for "carbon copy", this field is used to inform the
  (primary) recipient that copies have been sent to the people named here. This
  is similar to the "cc" field in emails, except of course you may actually have
  to make/print and send the copies yourself!

== The _enclosed_ field

The *_enclosed_ field*: this is used to give a list of enclosed (or _attached_)
  documents. Having a list of enclosed documents here helps the recipient to
  quickly get an overview over what the various attached documents are and also
  allows both the sender and recipient to quickly check that all the intended
  documents have actually been included.

== Falzmarken
What are *falzmarken*, anyways?

== Pagination
The *pagination*: the pagination gives the number of the current page, as well
  as typically indicating the overall number of pages. The principal purpose is
  to make the order of the pages unambigous (sometimes the intended order of
  loose pages is less obvious than you might think), as well as to be able to
  check that the set of pages is complete (if the total number of pages is
  included).


#pagebreak()

= The #pkg API <api-reference>