# frozen_string_literal: ture

require "test_helper"

module Graphql
  module Voyager
    module Rails
      class ConfigTest < ActiveSupport::TestCase
        class MockViewContext
          def form_authenticity_token
            "abc-123"
          end
        end

        setup do
          @config = Graphql::Voyager::Rails::Config.new
          @view_context = MockViewContext.new
        end

        test "it adds CSRF header if requested" do
          assert_equal "abc-123", @config.resolve_headers(@view_context)["X-CSRF-Token"]
          @config.csrf = false
          assert_nil @config.resolve_headers(@view_context)["X-CSRF-Token"]
        end

        test "it adds JSON header by default" do
          assert_equal "application/json", @config.resolve_headers(@view_context)["Content-Type"]
        end
      end
    end
  end
end
