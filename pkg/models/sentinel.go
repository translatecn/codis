// Copyright 2016 CodisLabs. All Rights Reserved.
// Licensed under the MIT (MIT-LICENSE.txt) license.

package models

type Sentinel struct {
	Servers   []string `json:"servers,omitempty"` // 存储了所有的哨兵节点
	OutOfSync bool     `json:"out_of_sync"`
}

func (p *Sentinel) Encode() []byte {
	return jsonEncode(p)
}
