guard :minitest do
  watch(/app\/.*/)          { 'test' }
  watch('config/routes.rb') { 'test' }
  watch(/test\/.*/)         { 'test' }
end

# # Makes sure tests run all the time for newly created files
# # and not just existing ones. \/
# callback([:run_on_additions_begin, :run_on_removals_begin]) do
#   minitest_plugin = Guard.state.session.plugins.all.find { |plugin| plugin.name == 'minitest' }
#   minitest_plugin.run_all
# end

# 40 minutes 28 seconds into lecture
