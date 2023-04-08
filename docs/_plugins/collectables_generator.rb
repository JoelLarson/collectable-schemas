require 'yaml'

class CollectablesGenerator < Jekyll::Generator
    safe true

    def generate(site)
        project_root = File.expand_path("#{site.source}/..")

        index_page = site.pages.find { |page| page.name == 'index.markdown' }

        index_page.data['collectables_list'] = [
            {
                'id' => 'pokemon-tcg',
                'name' => 'Pokemon Trading Card Game'
            }
        ]

        yaml_files = Dir.glob("#{project_root}/pokemon-tcg/index.{yaml}")
                        .reject { |f| File.directory?(f) || f.include?("#{project_root}/docs") }
                        .map { |path| YAML.load_file(path) }

        yaml_files.map! do |yaml_file|
            yaml_file['sets'].map! { |set| YAML.load_file("#{project_root}/pokemon-tcg#{set['$ref']}") }
            yaml_file
        end

        pages = []

        yaml_files.each do |yaml_file|
            page = ::CollectablesPage.new(site, site.source, '/collectables', "#{yaml_file['id']}.html")

            page.data['collectables'] = yaml_file

            pages << page

            yaml_file['sets'].each do |set|
                set_page = ::SetPage.new(site, site.source, "/collectables/#{yaml_file['id']}/sets", "#{set['id']}.html")

                set_page.data['collectables'] = yaml_file
                set_page.data['set'] = set
                
                pages << set_page

                set['locales'].each do |locale|
                    locale_page = ::LocalePage.new(site, site.source, "/collectables/#{yaml_file['id']}/sets/#{set['id']}/locales", "#{locale['id']}.html")

                    locale_page.data['collectables'] = yaml_file
                    locale_page.data['set'] = set
                    locale_page.data['_locale'] = locale
                    
                    pages << locale_page

                    locale['cards'].each do |card|
                        card_page = ::CardPage.new(site, site.source, "/collectables/#{yaml_file['id']}/sets/#{set['id']}/locales/#{locale['id']}/cards", "#{card['id']}.html")

                        card_page.data['collectables'] = yaml_file
                        card_page.data['set'] = set
                        card_page.data['_locale'] = locale
                        card_page.data['card'] = card
                        
                        pages << card_page
                    end
                end
            end
        end

        site.pages.concat pages
    end
end

class CollectablesPage < Jekyll::Page
    def initialize(site, base, dir, name)
        @site = site
        @base = base
        @dir  = dir
        @name = name

        template = 'collectables'

        @path = @site.layouts[template].path.dup
  
        process(name)

        read_yaml(Jekyll::PathManager.join(base, dir), name)
  
        data.default_proc = proc do |_, key|
          site.frontmatter_defaults.find(relative_path, type, key)
        end
  
        Jekyll::Hooks.trigger :pages, :post_init, self
    end
end

class SetPage < Jekyll::Page
    def initialize(site, base, dir, name)
        @site = site
        @base = base
        @dir  = dir
        @name = name

        template = 'set'

        @path = @site.layouts[template].path.dup
  
        process(name)

        read_yaml(Jekyll::PathManager.join(base, dir), name)
  
        data.default_proc = proc do |_, key|
          site.frontmatter_defaults.find(relative_path, type, key)
        end
  
        Jekyll::Hooks.trigger :pages, :post_init, self
    end
end

class LocalePage < Jekyll::Page
    def initialize(site, base, dir, name)
        @site = site
        @base = base
        @dir  = dir
        @name = name

        template = 'locale'

        @path = @site.layouts[template].path.dup
  
        process(name)

        read_yaml(Jekyll::PathManager.join(base, dir), name)
  
        data.default_proc = proc do |_, key|
          site.frontmatter_defaults.find(relative_path, type, key)
        end
  
        Jekyll::Hooks.trigger :pages, :post_init, self
    end
end

class CardPage < Jekyll::Page
    def initialize(site, base, dir, name)
        @site = site
        @base = base
        @dir  = dir
        @name = name

        template = 'card'

        @path = @site.layouts[template].path.dup
  
        process(name)

        read_yaml(Jekyll::PathManager.join(base, dir), name)
  
        data.default_proc = proc do |_, key|
          site.frontmatter_defaults.find(relative_path, type, key)
        end
  
        Jekyll::Hooks.trigger :pages, :post_init, self
    end
end