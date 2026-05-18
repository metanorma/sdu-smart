# frozen_string_literal: true

module SduSmart
  module Rdf
    module Namespaces
      autoload :SmartNamespace, "#{__dir__}/namespaces/smart_namespace"
      autoload :OaNamespace, "#{__dir__}/namespaces/oa_namespace"
      autoload :IsoIec80000Namespace, "#{__dir__}/namespaces/isoiec80000_namespace"
      autoload :DcatNamespace, "#{__dir__}/namespaces/dcat_namespace"
      autoload :ProvNamespace, "#{__dir__}/namespaces/prov_namespace"
      autoload :SkosXlNamespace, "#{__dir__}/namespaces/skosxl_namespace"
    end
  end
end
