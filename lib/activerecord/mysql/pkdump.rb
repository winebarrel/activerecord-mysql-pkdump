require 'active_record/schema_dumper'
require 'activerecord/mysql/pkdump/version'

module ActiveRecord
  class SchemaDumper
    private

    def table_with_pkdump(table, stream)
      buf = StringIO.new
      table_without_pkdump(table, buf)
      stream.print replace_create_table(table, buf.string)
      stream
    end
    alias_method_chain :table, :pkdump

    def replace_create_table(table, buf)
      columns = @connection.columns(table)
      tbl = StringIO.new
      pk = @connection.primary_key(table)

      tbl.print "  create_table #{remove_prefix_and_suffix(table).inspect}"
      pkcol = columns.detect { |c| c.name == pk }

      if pkcol
        if pk != 'id'
          tbl.print %Q(, primary_key: "#{pk}")
        end

        int_type = @types[:integer][:name]

        unless pkcol.sql_type =~ /\A#{int_type}/
          sql_type = [pkcol.sql_type, 'PRIMARY KEY', pkcol.extra].join(' ').strip
          tbl.print ", id: #{sql_type.inspect}"
        end
      else
        tbl.print ", id: false"
      end

      tbl.print ", force: true"
      tbl.puts " do |t|"

      tbl.string + buf.sub(/^\s*create_table.*\n/, '')
    end
  end
end
