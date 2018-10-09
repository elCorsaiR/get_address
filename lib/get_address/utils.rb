module GetAddress
  class Utils

    def self.escape_params(hash)
      result = []
      hash.each do |key, value|
        result.push "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
      end
      result.join('&')
    end

    def self.present?(param)
      param.respond_to?(:empty?) ? !param.empty? : !param.nil?
    end
  end
end