// Code generated by client-gen. DO NOT EDIT.

package fake

import (
	v1alpha1 "github.com/nginxinc/nginx-gateway-kubernetes/pkg/client/clientset/versioned/typed/gateway/v1alpha1"
	rest "k8s.io/client-go/rest"
	testing "k8s.io/client-go/testing"
)

type FakeGatewayV1alpha1 struct {
	*testing.Fake
}

func (c *FakeGatewayV1alpha1) GatewayConfigs() v1alpha1.GatewayConfigInterface {
	return &FakeGatewayConfigs{c}
}

// RESTClient returns a RESTClient that is used to communicate
// with API server by this client implementation.
func (c *FakeGatewayV1alpha1) RESTClient() rest.Interface {
	var ret *rest.RESTClient
	return ret
}