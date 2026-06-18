// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "@rails/ujs";
Rails.start();

import * as ActiveStorage from "@rails/activestorage";
ActiveStorage.start();

import Turbolinks from "turbolinks";
Turbolinks.start();
