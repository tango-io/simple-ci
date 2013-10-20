class RunTestsWorker
  include Sidekiq::Worker

  def perform(id)
    job = Job.find(id)

    vm = Ci::Environment.new(
      Ci::Buffer.new(job)
    )

    vm.upload_script("~/#{job.session_id}.sh", job.shell_script)
    vm.exec("chmod +x ~/#{job.session_id}.sh")
    vm.exec("./#{job.session_id}.sh")
    vm.session.close
  end

end
