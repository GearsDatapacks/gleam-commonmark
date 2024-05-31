//// This module defines the Markdown AST used.
////
//// This AST can be used to manipulate markdown documents or render them with your own
//// algorithm.
////
//// CommonMark defines two major types of elements which have a hierarchical relationship:
////
//// * A Document has many blocks.
//// * A block has zero or more inline elements that make up it's content.
//// * Inline elements define the textual contents of the document.

import gleam/dict.{type Dict}
import gleam/option.{type Option}

/// Inline nodes are used to define the formatting and individual elements that appear in a
/// document.
pub type InlineNode {
  CodeSpan(contents: String)
  Emphasis(contents: List(InlineNode))
  StrongEmphasis(contents: List(InlineNode))
  StrikeThrough(contents: List(InlineNode))
  Link(title: List(InlineNode), href: String)
  ReferenceLink(title: List(InlineNode), ref: String)
  Image(title: String, href: String)
  UriAutolink(href: String)
  EmailAutolink(href: String)
  HtmlInline(html: String)
  /// Text content shouldn't contain line breaks. See HardLineBreak and SoftLineBreak for the
  /// canonical representation of line breaks that renderers can make decisions about.
  Text(contents: String)
  HardLineBreak
  SoftLineBreak
}

pub type ListItem {
  ListItem(contents: List(BlockNode))
}

/// Block nodes are used to define the overall structure of a document.
pub type BlockNode {
  HorizontalBreak
  Heading(level: Int, contents: List(InlineNode))
  CodeBlock(info: Option(String), full_info: Option(String), contents: String)
  HtmlBlock(html: String)
  LinkReference(name: String, href: String)
  Paragraph(contents: List(InlineNode))
  BlockQuote(contents: List(BlockNode))
  OrderedList(contents: List(ListItem), start: Int)
  UnorderedList(contents: List(ListItem))
}

/// Documents contain all the information necessary to render a document, both structural and
/// metadata.
pub type Document {
  Document(blocks: List(BlockNode), references: Dict(String, String))
}
