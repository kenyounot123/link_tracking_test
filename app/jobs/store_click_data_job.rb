class StoreClickDataJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Successfully finished this job"
  end
end
