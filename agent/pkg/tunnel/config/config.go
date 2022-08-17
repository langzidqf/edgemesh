package config

import (
	meshConstants "github.com/kubeedge/edgemesh/common/constants"
	"github.com/kubeedge/edgemesh/common/security"
)

const (
	defaultListenPort = 20006
)

type TunnelAgentConfig struct {
	// Enable indicates whether TunnelAgent is enabled,
	// if set to false (for debugging etc.), skip checking other TunnelAgent configs.
	// default false
	Enable bool `json:"enable,omitempty"`
	// Security indicates the set of tunnel agent config about security
	Security *security.Security `json:"security,omitempty"`
	// NodeName indicates the node name of tunnel agent
	NodeName string `json:"nodeName,omitempty"`
	// ListenPort indicates the listen port of tunnel agent
	// default 20006
	ListenPort int `json:"listenPort,omitempty"`
	// EnableHolePunch indicates whether p2p hole punching feature is enabled,
	// default true
	EnableHolePunch bool `json:"enableHolePunch,omitempty"`
	// Transport indicates the transport protocol used by the p2p tunnel
	Transport string `json:"transport,omitempty"`
	// RelayNodes indicates some nodes that can become libp2p relay nodes
	RelayNodes []*RelayNode `json:"relayNodes,omitempty"`
}

type RelayNode struct {
	// NodeName indicates the relay node name, which is the same as the node name of Kubernetes
	NodeName string `json:"nodeName,omitempty"`
	// AdvertiseAddress sets the IP address for the relay node to advertise
	AdvertiseAddress []string `json:"advertiseAddress,omitempty"`
}

func NewTunnelAgentConfig() *TunnelAgentConfig {
	return &TunnelAgentConfig{
		Enable: false,
		Security: &security.Security{
			Enable:            false,
			TLSPrivateKeyFile: meshConstants.AgentDefaultKeyFile,
			TLSCAFile:         meshConstants.AgentDefaultCAFile,
			TLSCertFile:       meshConstants.AgentDefaultCertFile,
		},
		ListenPort:      defaultListenPort,
		EnableHolePunch: true,
		Transport:       "tcp",
	}
}
