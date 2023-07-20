class FileImporter
  def initialize(file)
    @file = file
    @log = []
  end

  def import
    @file = File.new(@file)
    input = JSON.parse(@file.read)

    if input['restaurants'].present?
      input['restaurants'].each do |restaurant|
        rest = import_restaurant(restaurant)
        if restaurant['menus'].present?
          restaurant['menus'].each do |menu|
            men = import_menu(rest, menu)
            menu_items = (menu['menu_items'] || []) + (menu['dishes'] || [])
            if menu_items.present?
              menu_items.each do |menu_item|
                import_menu_item(men, menu_item)
              end
            end
          end
        end
      end
    end
  rescue Errno::ENOENT
    @log << 'Failure: The provided file does not exist.'
  rescue JSON::ParserError
    @log << 'Failure: The provided file does not contain valid JSON.'
  ensure
    return @log
  end

  private

  def import_restaurant(restaurant)
    rest = Restaurant.find_or_create_by(name: restaurant['name'])
    if rest.errors.count > 0
      @log << "Failure: #{restaurant.except('menus')},  #{rest.errors.full_messages}"
      return false
    end

    @log << "Success: restaurant '#{rest.name}'"
    rest
  end

  def import_menu(rest, menu)
    unless rest
      @log << "Failure: no valid restaurant for menu '#{menu['name']}'."
      return false
    end

    men = Menu.find_or_create_by(name: menu['name'], restaurant: rest)
    if men.errors.count > 0
      @log << "Failure: #{menu.except('menu_items')},  #{men.errors.full_messages}"
      return false
    end

    @log << "Success: restaurant '#{rest.name}', menu '#{men.name}'"
    men
  end

  def import_menu_item(men, menu_item)
    m_item = MenuItem.find_or_create_by(name: menu_item['name'])
    if m_item.errors.count > 0
      @log << "Failure: #{menu_item},  #{m_item.errors.full_messages}"
      return false
    end

    m_item_menu = MenuItemsMenu.create_with(price: menu_item['price']).find_or_create_by(menu_id: men.id, menu_item_id: m_item.id)
    m_item_menu.update(price: menu_item['price'])
    if m_item_menu.errors.count > 0
      @log << "Failure: #{menu_item},  #{m_item_menu.errors.full_messages}"
      return false
    end

    @log << "Success: '#{m_item.name}', $#{sprintf('%.2f', m_item_menu.price)}"

    true
  end
end