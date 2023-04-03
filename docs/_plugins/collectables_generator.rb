require 'yaml'

class CollectablesGenerator < Jekyll::Generator
    safe true

    def generate(site)
        collectable = YAML.load_file(File.expand_path("#{site.source}/../pokemon-tcg/index.yaml"))

        collectable['sets'].map! { |set| YAML.load_file(File.expand_path("#{site.source}/../pokemon-tcg#{set['$ref']}")) }

        site.data['collectables'] = {
            'pokemon-tcg' => collectable
        }
    end
end

# class CollectablesPage < Jekyll::Page
#     def initialize(site, base, dir, name)
#         @site = site
#         @base = base
#         @dir  = dir
#         @name = name
#         @path = if site.in_theme_dir(base) == base # we're in a theme
#                   site.in_theme_dir(base, dir, name)
#                 else
#                   site.in_source_dir(base, dir, name)
#                 end

#         puts "#{@base} #{@dir} #{@name} #{@path}"

#         process(name)
#         read_yaml(PathManager.join(base, dir), name)
#         generate_excerpt if site.config["page_excerpts"]
  
#         data.default_proc = proc do |_, key|
#           site.frontmatter_defaults.find(relative_path, type, key)
#         end
  
#         Jekyll::Hooks.trigger :pages, :post_init, self
#     end
# end