describe 'metadata' do
  let(:graph) {Graph.new}

  it 'check metadata', foo: true do |example|
    p example.metadata
    example.metadata.each_key do |a|
      keys = [:block, :description_args, :description, :full_description, :described_class, :file_path, :line_number, :location,
              :absolute_file_path, :rerun_file_path, :scoped_id, :execution_result, :example_group, :shared_group_inclusion_backtrace,
              :last_run_status]
      unless keys.include? a
        p a
      end
    end
  end
end