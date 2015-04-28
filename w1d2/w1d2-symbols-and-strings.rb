def super_print(string, options={})
  defaults = {
               times: 1,
               upcase: false,
               reverse: false
             }

  parameters = defaults.merge(options)

  string.upcase! if parameters[:upcase]
  string.reverse! if parameters[:reverse]
  string*parameters[:times]

end
