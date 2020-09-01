/* eslint no-console:0 */

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

require("@rails/ujs").start()
require("turbolinks").start()

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

