require "jekyll-import";

JekyllImport::Importers::Tumblr.run({
    "url"            => "http://beekley.xyz",
    "format"         => "html", # "md" misses links and images etc
    "grab_images"    => true,
    "add_highlights" => false,
    "rewrite_urls"   => false # `true` breaks build
})
