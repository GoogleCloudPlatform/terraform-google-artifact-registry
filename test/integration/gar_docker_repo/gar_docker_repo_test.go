// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package docker_repo

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestDockerRepoCreation(t *testing.T) {
	gar_docker_repoT := tft.NewTFBlueprintTest(t)

	gar_docker_repoT.DefineVerify(func(assert *assert.Assertions) {
		repositoryID := gar_docker_repoT.GetStringOutput("repository_id")
		projectID := gar_docker_repoT.GetStringOutput("project_id")
		repo_location := gar_docker_repoT.GetStringOutput("repo_location")
		create_time := gar_docker_repoT.GetStringOutput("create_time")

		repo_cmd := gcloud.Run(t, "artifacts repositories describe", gcloud.WithCommonArgs([]string{repositoryID, "--project", projectID, "--location", repo_location, "--format", "json"}))

		// T01: Verify if the Artifact Registry is created successfully
		assert.Equal(repositoryID, repo_cmd.Get("name").String(), fmt.Sprintf("Artifact ID mismatch. Artifact Registry is not created successfully."))

		// T02: Verify Artifact Registry create time
		assert.Equal(create_time, repo_cmd.Get("createTime").String(), fmt.Sprintf("Create Time mismatch. Artifact Registry is not created successfully."))
	})
	gar_docker_repoT.Test()
}
