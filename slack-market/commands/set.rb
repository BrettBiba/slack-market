module SlackMarket
  module Commands
    class Set < SlackRubyBot::Commands::Base
      include SlackMarket::Commands::Mixins::Subscribe

      subscribe_command 'set' do |client, data, match|
        if !match['expression']
          client.say(channel: data.channel, text: 'Missing setting, eg. _set dollars on_.', gif: 'help')
          logger.info "SET: #{client.owner} - failed, missing setting"
        else
          k, v = match['expression'].split(/\W+/, 2)
          case k
          when 'charts' then
            client.owner.update_attributes!(charts: v.to_b) unless v.nil?
            client.say(channel: data.channel, text: "Charts for team #{client.owner.name} are #{client.owner.charts? ? 'on!' : 'off.'}", gif: 'charts')
            logger.info "SET: #{client.owner} - charts are #{client.owner.charts? ? 'on' : 'off'}"
          when 'dollars' then
            client.owner.update_attributes!(dollars: v.to_b) unless v.nil?
            client.say(channel: data.channel, text: "Dollar signs for team #{client.owner.name} are #{client.owner.dollars? ? 'on!' : 'off.'}", gif: 'dollars')
            logger.info "SET: #{client.owner} - dollar signs are #{client.owner.dollars? ? 'on' : 'off'}"
          else
            raise "Invalid setting #{k}, you can _set dollars on|off_."
          end
        end
      end
    end
  end
end
